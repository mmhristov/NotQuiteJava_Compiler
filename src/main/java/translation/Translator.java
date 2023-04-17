package translation;

import analysis.ArrayType;
import analysis.ClassType;
import analysis.InterfaceType;
import minillvm.ast.*;
import notquitejava.ast.*;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import static frontend.AstPrinter.print;
import static minillvm.ast.Ast.*;


/**
 * Entry class for the translation phase.
 */
public class Translator {

    private final StmtTranslator stmtTranslator = new StmtTranslator(this);
    private final ExprLValue exprLValue = new ExprLValue(this);
    private final ExprRValue exprRValue = new ExprRValue(this);
    private final Map<NQJFunctionDecl, Proc> functionImpl = new HashMap<>();
    private final Map<NQJFunctionDecl, Proc> methodImpl = new HashMap<>();
    private final Prog prog = Prog(TypeStructList(), GlobalList(), ProcList());
    private final NQJProgram javaProg;
    private final Map<NQJVarDecl, TemporaryVar> localVarLocation = new HashMap<>();
    private final Map<analysis.Type, Type> translatedType = new HashMap<>();
    private final Map<Type, TypeStruct> arrayStructs = new HashMap<>();
    private final Map<Type, Proc> newArrayFuncForType = new HashMap<>();

    /**
     * A mapping of class names to their corresponding type structures.
     */
    private final Map<String, TypeStruct> classStructs = new HashMap<>();

    /**
     * Stores default constructor procedures  (analogous to newArrayFuncForType).
     */
    private final Map<String, Proc> constructorProcs = new HashMap<>();

    /**
     * Stores the vTable structures of classes.
     * Key: the name of the class structure. Value: the vTable structure.
     */
    // todo: check if key can be TypeStruct obj.
    private final Map<String, TypeStruct> vTableStructs = new HashMap<>();

    /**
     * Stores the vTable global variables of classes.
     * (this data is also contained in prog.getGlobals(), but for easier retrieval we will model it
     *  as in the struct maps' case as a separate map).
     */
    private final Map<String, Global> vTableGlobals = new HashMap<>();

    // mutable state
    private Proc currentProcedure;
    private BasicBlock currentBlock;

    public Translator(NQJProgram javaProg) {
        this.javaProg = javaProg;
    }

    /**
     * Translates given program into a mini llvm program.
     */
    public Prog translate() {
        // translate classes before global functions
        translateClasses();

        // translate functions except main
        // has only access to functions
        translateFunctions();

        // translate main function
        // has access to functions
        translateMainFunction();

        finishNewArrayProcs();

        return prog;
    }

    private void translateClasses() {
        NQJClassDeclList classDecls =  javaProg.getClassDecls();
        for (NQJClassDecl classDecl : classDecls) {
            initClass(classDecl);
        }

        for (NQJClassDecl classDecl : classDecls) {
            initClassMethods(classDecl);
        }

        for (NQJClassDecl classDecl : classDecls) {
            // Don't move this inside the initClass() loop.
            // This ensures that all classes are known
            // before e.g. creating methods that have classes as params
            translateClass(classDecl);
        }
    }

    private void initClassMethods(NQJClassDecl classDecl) {
        for (NQJFunctionDecl m : classDecl.getMethods()) {
            String className = classDecl.getName();
            TypeStruct struct = classStructs.get(className);
            if (struct == null) {
                // this should never possible to happen
                // as classStructs should be filled at this point
                throw new IllegalStateException(
                        "Declaration for class " + className + " was not found!"
                );
            }
            initClassMethod(m, struct);
        }
    }

    private void initClassMethod(NQJFunctionDecl methodDecl, TypeStruct classStruct) {
        // get return type
        Type t = translateType(methodDecl.getReturnType());
        // get parameters
        ParameterList params = methodDecl.getFormalParameters()
                .stream()
                .map(p -> Parameter(translateType(p.getType()), p.getName()))
                .collect(Collectors.toCollection(Ast::ParameterList)); // taken from initFunction()
        // add "this" object as first parameter like in lecture
        TypePointer typePointer = TypePointer(classStruct);
        params.addFront(Parameter(typePointer, "this"));

        // create and add procedure
        Proc p = Proc(methodDecl.getName(), t, params, BasicBlockList());
        addProcedure(p);
        methodImpl.put(methodDecl, p);
    }

    private void translateClass(NQJClassDecl classDecl) {
        // create vTable and fill with methods
        StructFieldList procedureFields = StructFieldList();
        ConstList procedureReferences = ConstList();
        for (NQJFunctionDecl method : classDecl.getMethods()) {
            ProcedureRef procedureRef = ProcedureRef(methodImpl.get(method));
            StructField procedureField = StructField(
                    procedureRef.calculateType(),
                    method.getName()
            );
            procedureFields.add(procedureField);
            procedureReferences.add(procedureRef);
        }

        TypeStruct vTable = TypeStruct(
                "vTable_" + classDecl.getName(), procedureFields);
        prog.getStructTypes().add(vTable);
        ConstStruct vtableData = ConstStruct(vTable, procedureReferences);

        Global vTableGlobal = Global(
                vTable,
                "vTableGlobal_" + classDecl.getName(),
                true, // check if this is ok
                vtableData
        );
        prog.getGlobals().add(vTableGlobal);
        prog.getStructTypes().add(vTable.copy());
        vTableGlobals.put(classDecl.getName(), vTableGlobal);

        String className = classDecl.getName();
        TypeStruct classStruct = classStructs.get(className);
        // note: key is the name of the class STRUCT, not declaration!
        vTableStructs.put(classStruct.getName(), vTable);

        // first field is always filled with the pointer to the vTable
        classStruct.getFields().add(StructField(TypePointer(vTable), "vTable"));

        // add fields to struct
        for (final NQJVarDecl fieldDecl : classDecl.getFields()) {
            classStruct.getFields().add(
                    StructField(
                            translateType(fieldDecl.getType()),
                            fieldDecl.getName()
                    )
            );
        }

        // translate methods
        for (NQJFunctionDecl methodDecl : classDecl.getMethods()) {
            translateMethod(methodDecl);
        }

        // create default constructor procedure
        getConstructorProcedure(className);
    }

    /**
     * Initializes the needed structure for the given class.
     *
     * @param classDecl the class declaration
     */
    private void initClass(NQJClassDecl classDecl) {
        String className = classDecl.getName();
        if (classStructs.containsKey(className)) {
            return;
        }

        TypeStruct typeStruct = TypeStruct("class_" + className, StructFieldList());
        classStructs.put(className, typeStruct);
        prog.getStructTypes().add(typeStruct);
    }

    TemporaryVar getLocalVarLocation(NQJVarDecl varDecl) {
        return localVarLocation.get(varDecl);
    }

    private void finishNewArrayProcs() {
        for (Type type : newArrayFuncForType.keySet()) {
            finishNewArrayProc(type);
        }
    }

    private void finishNewArrayProc(Type componentType) {
        final Proc newArrayFunc = newArrayFuncForType.get(componentType);
        final Parameter size = newArrayFunc.getParameters().get(0);

        addProcedure(newArrayFunc);
        setCurrentProc(newArrayFunc);

        BasicBlock init = newBasicBlock("init");
        addBasicBlock(init);
        setCurrentBlock(init);
        TemporaryVar sizeLessThanZero = TemporaryVar("sizeLessThanZero");
        addInstruction(BinaryOperation(sizeLessThanZero,
                VarRef(size), Slt(), ConstInt(0)));
        BasicBlock negativeSize = newBasicBlock("negativeSize");
        BasicBlock goodSize = newBasicBlock("goodSize");
        currentBlock.add(Branch(VarRef(sizeLessThanZero), negativeSize, goodSize));

        addBasicBlock(negativeSize);
        negativeSize.add(HaltWithError("Array Size must be positive"));

        addBasicBlock(goodSize);
        setCurrentBlock(goodSize);

        // allocate space for the array

        TemporaryVar arraySizeInBytes = TemporaryVar("arraySizeInBytes");
        addInstruction(BinaryOperation(arraySizeInBytes,
                VarRef(size), Mul(), byteSize(componentType)));

        // 4 bytes for the length
        TemporaryVar arraySizeWithLen = TemporaryVar("arraySizeWitLen");
        addInstruction(BinaryOperation(arraySizeWithLen,
                VarRef(arraySizeInBytes), Add(), ConstInt(4)));

        TemporaryVar mallocResult = TemporaryVar("mallocRes");
        addInstruction(Alloc(mallocResult, VarRef(arraySizeWithLen)));
        TemporaryVar newArray = TemporaryVar("newArray");
        addInstruction(Bitcast(newArray,
                getArrayPointerType(componentType), VarRef(mallocResult)));

        // store the size
        TemporaryVar sizeAddr = TemporaryVar("sizeAddr");
        addInstruction(GetElementPtr(sizeAddr,
                VarRef(newArray), OperandList(ConstInt(0), ConstInt(0))));
        addInstruction(Store(VarRef(sizeAddr), VarRef(size)));

        // initialize Array with zeros:
        final BasicBlock loopStart = newBasicBlock("loopStart");
        final BasicBlock loopBody = newBasicBlock("loopBody");
        final BasicBlock loopEnd = newBasicBlock("loopEnd");
        final TemporaryVar iVar = TemporaryVar("iVar");
        currentBlock.add(Alloca(iVar, TypeInt()));
        currentBlock.add(Store(VarRef(iVar), ConstInt(0)));
        currentBlock.add(Jump(loopStart));

        // loop condition: while i < size
        addBasicBlock(loopStart);
        setCurrentBlock(loopStart);
        final TemporaryVar i = TemporaryVar("i");
        final TemporaryVar nextI = TemporaryVar("nextI");
        loopStart.add(Load(i, VarRef(iVar)));
        TemporaryVar smallerSize = TemporaryVar("smallerSize");
        addInstruction(BinaryOperation(smallerSize,
                VarRef(i), Slt(), VarRef(size)));
        currentBlock.add(Branch(VarRef(smallerSize), loopBody, loopEnd));

        // loop body
        addBasicBlock(loopBody);
        setCurrentBlock(loopBody);
        // ar[i] = 0;
        final TemporaryVar iAddr = TemporaryVar("iAddr");
        addInstruction(GetElementPtr(iAddr,
                VarRef(newArray), OperandList(ConstInt(0), ConstInt(1), VarRef(i))));
        addInstruction(Store(VarRef(iAddr), defaultValue(componentType)));

        // nextI = i + 1;
        addInstruction(BinaryOperation(nextI, VarRef(i), Add(), ConstInt(1)));
        // store new value in i
        addInstruction(Store(VarRef(iVar), VarRef(nextI)));

        loopBody.add(Jump(loopStart));

        addBasicBlock(loopEnd);
        loopEnd.add(ReturnExpr(VarRef(newArray)));
    }

    private void translateFunctions() {
        for (NQJFunctionDecl functionDecl : javaProg.getFunctionDecls()) {
            if (functionDecl.getName().equals("main")) {
                continue;
            }
            initFunction(functionDecl);
        }
        for (NQJFunctionDecl functionDecl : javaProg.getFunctionDecls()) {
            if (functionDecl.getName().equals("main")) {
                continue;
            }
            translateFunction(functionDecl);
        }
    }

    private void translateMainFunction() {
        NQJFunctionDecl f = null;
        for (NQJFunctionDecl functionDecl : javaProg.getFunctionDecls()) {
            if (functionDecl.getName().equals("main")) {
                f = functionDecl;
                break;
            }
        }

        if (f == null) {
            throw new IllegalStateException("Main function expected");
        }

        Proc proc = Proc("main", TypeInt(), ParameterList(), BasicBlockList());
        addProcedure(proc);
        functionImpl.put(f, proc);

        setCurrentProc(proc);
        BasicBlock initBlock = newBasicBlock("init");
        addBasicBlock(initBlock);
        setCurrentBlock(initBlock);

        // allocate space for the local variables
        allocaLocalVars(f.getMethodBody());

        // translate
        translateStmt(f.getMethodBody());
    }

    private void initFunction(NQJFunctionDecl f) {
        Type returnType = translateType(f.getReturnType());
        ParameterList params = f.getFormalParameters()
                .stream()
                .map(p -> Parameter(translateType(p.getType()), p.getName()))
                .collect(Collectors.toCollection(Ast::ParameterList));
        Proc proc = Proc(f.getName(), returnType, params, BasicBlockList());
        addProcedure(proc);
        functionImpl.put(f, proc);
    }

    private void translateFunction(NQJFunctionDecl functionDecl) {
        translateFunctionInternal(functionDecl, false);
    }

    private void translateMethod(NQJFunctionDecl methodDecl) {
        translateFunctionInternal(methodDecl, true);
    }

    private void translateFunctionInternal(NQJFunctionDecl m, boolean isMethod) {
        int i = 0;
        Proc proc = null;
        if (isMethod) {
            i = 1; // offset because of "this" object
            proc = methodImpl.get(m);
        } else {
            proc = functionImpl.get(m);
        }

        setCurrentProc(proc);
        BasicBlock initBlock = newBasicBlock("init");
        addBasicBlock(initBlock);
        setCurrentBlock(initBlock);

        localVarLocation.clear();
        // store copies of the parameters in Allocas, to make uniform read/write access possible
        for (NQJVarDecl param : m.getFormalParameters()) {
            TemporaryVar v = TemporaryVar(param.getName());
            addInstruction(Alloca(v, translateType(param.getType())));
            addInstruction(Store(VarRef(v), VarRef(proc.getParameters().get(i))));
            localVarLocation.put(param, v);
            i++;
        }

        // allocate space for the local variables
        allocaLocalVars(m.getMethodBody());

        translateStmt(m.getMethodBody());
    }

    void translateStmt(NQJStatement s) {
        addInstruction(CommentInstr(sourceLine(s) + " start statement : " + printFirstline(s)));
        s.match(stmtTranslator);
        addInstruction(CommentInstr(sourceLine(s) + " end statement: " + printFirstline(s)));
    }

    int sourceLine(NQJElement e) {
        while (e != null) {
            if (e.getSourcePosition() != null) {
                return e.getSourcePosition().getLine();
            }
            e = e.getParent();
        }
        return 0;
    }

    private String printFirstline(NQJStatement s) {
        String str = print(s);
        str = str.replaceAll("\n.*", "");
        return str;
    }

    BasicBlock newBasicBlock(String name) {
        BasicBlock block = BasicBlock();
        block.setName(name);
        return block;
    }

    void addBasicBlock(BasicBlock block) {
        currentProcedure.getBasicBlocks().add(block);
    }

    public BasicBlock getCurrentBlock() {
        return currentBlock;
    }

    public Proc getCurrentProcedure() {
        return currentProcedure;
    }

    void setCurrentBlock(BasicBlock currentBlock) {
        this.currentBlock = currentBlock;
    }


    void addProcedure(Proc proc) {
        prog.getProcedures().add(proc);
    }

    void setCurrentProc(Proc currentProc) {
        if (currentProc == null) {
            throw new RuntimeException("Cannot set proc to null");
        }
        this.currentProcedure = currentProc;
    }

    private void allocaLocalVars(NQJBlock methodBody) {
        methodBody.accept(new NQJElement.DefaultVisitor() {
            @Override
            public void visit(NQJVarDecl localVar) {
                super.visit(localVar);
                TemporaryVar v = TemporaryVar(localVar.getName());
                addInstruction(Alloca(v, translateType(localVar.getType())));
                localVarLocation.put(localVar, v);
            }
        });
    }

    void addInstruction(Instruction instruction) {
        currentBlock.add(instruction);
    }

    Type translateType(NQJType type) {
        return translateType(type.getType());
    }

    Type translateType(analysis.Type t) {
        Type result = translatedType.get(t);
        if (result == null) {
            if (t == analysis.Type.INT) {
                result = TypeInt();
            } else if (t == analysis.Type.BOOL) {
                result = TypeBool();
            } else if (t instanceof ArrayType) {
                ArrayType at = (ArrayType) t;
                result = TypePointer(getArrayStruct(translateType(at.getBaseType())));
            } else if (t instanceof ClassType) {
                ClassType ct = (ClassType) t;
                result = TypePointer(classStructs.get(ct.getName()));
            } else if (t instanceof InterfaceType) {
                InterfaceType it = (InterfaceType) t;
                result = TypePointer(classStructs.get(it.getClassImplementation().getName()));
            } else {
                throw new RuntimeException("unhandled case " + t);
            }
            translatedType.put(t, result);
        }
        return result;
    }

    Parameter getThisParameter() {
        // in our case 'this' is always the first parameter
        return currentProcedure.getParameters().get(0);
    }

    Operand exprLvalue(NQJExprL e) {
        return e.match(exprLValue);
    }

    Operand exprRvalue(NQJExpr e) {
        return e.match(exprRValue);
    }

    void addNullcheck(Operand arrayAddr, String errorMessage) {
        TemporaryVar isNull = TemporaryVar("isNull");
        addInstruction(BinaryOperation(isNull, arrayAddr.copy(), Eq(), Nullpointer()));

        BasicBlock whenIsNull = newBasicBlock("whenIsNull");
        BasicBlock notNull = newBasicBlock("notNull");
        currentBlock.add(Branch(VarRef(isNull), whenIsNull, notNull));

        addBasicBlock(whenIsNull);
        whenIsNull.add(HaltWithError(errorMessage));

        addBasicBlock(notNull);
        setCurrentBlock(notNull);
    }

    Operand getArrayLen(Operand arrayAddr) {
        TemporaryVar addr = TemporaryVar("length_addr");
        addInstruction(GetElementPtr(addr,
                arrayAddr.copy(), OperandList(ConstInt(0), ConstInt(0))));
        TemporaryVar len = TemporaryVar("len");
        addInstruction(Load(len, VarRef(addr)));
        return VarRef(len);
    }

    public Operand getNewArrayFunc(Type componentType) {
        Proc proc = newArrayFuncForType.computeIfAbsent(componentType, this::createNewArrayProc);
        return ProcedureRef(proc);
    }

    private Proc createNewArrayProc(Type componentType) {
        Parameter size = Parameter(TypeInt(), "size");
        return Proc("newArray",
                getArrayPointerType(componentType), ParameterList(size), BasicBlockList());
    }

    private Type getArrayPointerType(Type componentType) {
        return TypePointer(getArrayStruct(componentType));
    }

    TypeStruct getArrayStruct(Type type) {
        return arrayStructs.computeIfAbsent(type, t -> {
            TypeStruct struct = TypeStruct("array_" + type, StructFieldList(
                    StructField(TypeInt(), "length"),
                    StructField(TypeArray(type, 0), "data")
            ));
            prog.getStructTypes().add(struct);
            return struct;
        });
    }

    Operand addCastIfNecessary(Operand value, Type expectedType) {
        if (expectedType.equalsType(value.calculateType())) {
            return value;
        }
        TemporaryVar castValue = TemporaryVar("castValue");
        addInstruction(Bitcast(castValue, expectedType, value));
        return VarRef(castValue);
    }

    BasicBlock unreachableBlock() {
        return BasicBlock();
    }

    Type getCurrentReturnType() {
        return currentProcedure.getReturnType();
    }

    public Proc loadFunctionProc(NQJFunctionDecl functionDeclaration) {
        return functionImpl.get(functionDeclaration);
    }

    /**
     * return the number of bytes required by the given type.
     */
    public Operand byteSize(Type type) {
        return type.match(new Type.Matcher<>() {
            @Override
            public Operand case_TypeByte(TypeByte typeByte) {
                return ConstInt(1);
            }

            @Override
            public Operand case_TypeArray(TypeArray typeArray) {
                throw new RuntimeException("TODO implement");
            }

            @Override
            public Operand case_TypeProc(TypeProc typeProc) {
                throw new RuntimeException("TODO implement");
            }

            @Override
            public Operand case_TypeInt(TypeInt typeInt) {
                return ConstInt(4);
            }

            @Override
            public Operand case_TypeStruct(TypeStruct typeStruct) {
                return Sizeof(typeStruct);
            }

            @Override
            public Operand case_TypeNullpointer(TypeNullpointer typeNullpointer) {
                return ConstInt(8);
            }

            @Override
            public Operand case_TypeVoid(TypeVoid typeVoid) {
                return ConstInt(0);
            }

            @Override
            public Operand case_TypeBool(TypeBool typeBool) {
                return ConstInt(1);
            }

            @Override
            public Operand case_TypePointer(TypePointer typePointer) {
                return ConstInt(8);
            }
        });
    }

    private Operand defaultValue(Type componentType) {
        return componentType.match(new Type.Matcher<>() {
            @Override
            public Operand case_TypeByte(TypeByte typeByte) {
                throw new RuntimeException("TODO implement");
            }

            @Override
            public Operand case_TypeArray(TypeArray typeArray) {
                throw new RuntimeException("TODO implement");
            }

            @Override
            public Operand case_TypeProc(TypeProc typeProc) {
                throw new RuntimeException("TODO implement");
            }

            @Override
            public Operand case_TypeInt(TypeInt typeInt) {
                return ConstInt(0);
            }

            @Override
            public Operand case_TypeStruct(TypeStruct typeStruct) {
                throw new RuntimeException("TODO implement");
            }

            @Override
            public Operand case_TypeNullpointer(TypeNullpointer typeNullpointer) {
                return Nullpointer();
            }

            @Override
            public Operand case_TypeVoid(TypeVoid typeVoid) {
                throw new RuntimeException("TODO implement");
            }

            @Override
            public Operand case_TypeBool(TypeBool typeBool) {
                return ConstBool(false);
            }

            @Override
            public Operand case_TypePointer(TypePointer typePointer) {
                return Nullpointer();
            }
        });
    }

    /**
     * Retrieves the default constructor procedure
     *  for the class with the given parameter name.
     *  If the constructor had not been created at the time of call,
     *  it will be created and returned.
     *
     * @param className the name of the class,
     *                  for which the default constructor should be returned
     * @return the constructor procedure for the class with the parameter name
     */
    public Operand getConstructorProcedure(String className) {
        Proc result = constructorProcs.get(className);
        if (result == null) {
            result = createConstructorProcedure(className);
        }
        // add constructor procedure for class in map
        constructorProcs.put(className, result);
        return ProcedureRef(result);
    }

    /**
     * Creates the default constructor procedure
     *  for the class with the given parameter name.
     *
     * @param className the name of the class,
     *                  for which the default constructor should be created
     * @return the constructor procedure for the class with the parameter name
     */
    private Proc createConstructorProcedure(String className) {
        // get class struct
        TypeStruct struct = getClassStruct(className);
        // init constructor object
        Proc res = Proc(
                "constructor_" + className,
                TypePointer(struct),
                ParameterList(),
                BasicBlockList()
        );

        addProcedure(res);
        setCurrentProc(res);
        BasicBlock constructorBlock = newBasicBlock("constructorBlock");
        addBasicBlock(constructorBlock);
        setCurrentBlock(constructorBlock);

        // allocate memory for object
        TemporaryVar mallocVar = TemporaryVar("mallocVar");
        addInstruction(Alloc(mallocVar, Sizeof(struct)));
        // cast to class struct
        TemporaryVar newClass = TemporaryVar("newClass");
        addInstruction(Bitcast(newClass, TypePointer(struct), VarRef(mallocVar)));

        // store vTable as first field
        TemporaryVar address = TemporaryVar("address");
        addInstruction(
                GetElementPtr(
                        address,
                        VarRef(newClass),
                        OperandList(ConstInt(0), ConstInt(0))
                )
        );
        addInstruction(
                Store(
                        VarRef(address),
                        GlobalRef(vTableGlobals.get(className))
                )
        );

        fillFieldsWithDefaultValues(VarRef(newClass), struct.getFields());

        // return statement
        addInstruction(
                ReturnExpr(VarRef(newClass))
        );

        return res;
    }


    /**
     * Fills the given fields in the reference of the class with default values.
     *
     * @param newClassObjRef the reference to the class
     * @param fields the fields, which are to be filled with default values
     */
    private void fillFieldsWithDefaultValues(VarRef newClassObjRef, StructFieldList fields) {
        for (int i = 1; i < fields.size(); i++) {
            StructField field = fields.get(i);
            // this should always be the case,
            // since the first field is always a pointer to the vTable
            if (!(field.getName().equals("vTable"))) {
                TemporaryVar fieldTempVar = TemporaryVar(
                        "fieldTempVar_" + field.getName());
                addInstruction(
                        GetElementPtr(
                                fieldTempVar,
                                newClassObjRef.copy(),
                                OperandList(ConstInt(0), ConstInt(i))
                        ) // note the index i here
                );
                addInstruction(
                        Store(VarRef(fieldTempVar), defaultValue(field.getType()))
                );
            } else {
                throw new IllegalStateException(
                        "The vTable pointer is not the first field of the class struct!"
                );
            }
        }
    }

    public TypeStruct getClassStruct(String className) {
        return classStructs.get(className);
    }

    public TypeStruct getVTableStruct(String classStructName) {
        return vTableStructs.get(classStructName);
    }
}
