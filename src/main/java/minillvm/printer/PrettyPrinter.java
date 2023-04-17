package minillvm.printer;

import frontend.SourcePosition;
import minillvm.analysis.ExpectedType;
import minillvm.analysis.Typechecker;
import minillvm.ast.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Pretty printer for mini llvm ast classes.
 */
public class PrettyPrinter implements
        Element.MatcherVoid {

    private final StringBuilder sb;
    private boolean includeType;
    private final Map<String, String> stringConstantNames = new HashMap<>();
    private final Map<Element, SourcePosition> sourcePositions = new HashMap<>();
    private int currentLine = 1;
    private int currentColumn = 0;

    public PrettyPrinter(StringBuilder sb) {
        this.sb = sb;
    }

    /**
     * Element -> String.
     */
    public static String elementToString(Element e) {
        if (e instanceof TypeStruct) {
            return "%" + getName(((TypeStruct) e));
        } else if (e instanceof BasicBlock) {
            return getName((BasicBlock) e);
        }
        StringBuilder sb = new StringBuilder();
        try {
            new PrettyPrinter(sb).print(e);
            return sb.toString();
        } catch (Exception ex) {
            ex.printStackTrace();
            return "[Error in printing " + e.getClass().getSimpleName() + " ... " + sb + "]";
        }
    }

    /**
     * returns the name of an element and escapes it for printing if necessary.
     */
    private static String getName(ElementWithName e) {
        String name = e.getName();
        if (name.matches("[-a-zA-Z$._][-a-zA-Z$._0-9]*")) {
            // matches regexp for identifiers given in http://llvm.org/docs/LangRef.html#identifiers
            return name;
        }
        // otherwise we write the name in quotes and escape some special characters:
        return escapeString(name);
    }

    private static String getName(BasicBlock e) {
        String name = e.getName();
        if (name == null) {
            name = "block";
        }
        if (name.matches("[-a-zA-Z$._][-a-zA-Z$._0-9]*")) {
            // matches regexp for identifiers given in http://llvm.org/docs/LangRef.html#identifiers
            return name;
        }
        // otherwise we write the name in quotes and escape some special characters:
        return escapeString(name);
    }

    private static String escapeString(String name) {
        StringBuilder res = new StringBuilder();
        res.append("\"");
        for (int i = 0; i < name.length(); i++) {
            char c = name.charAt(i);
            if (c < 32 || c == '\'' || c == '\"' || c == '\\') {
                res.append("\\");
                res.append(String.format("%02X", (int) c));
            } else {
                res.append(c);
            }
        }
        res.append("\"");
        return res.toString();
    }

    private void print(Element e) {
        includeType = false;
        print2(e);
    }

    private void printWithType(Element e) {
        includeType = true;
        print2(e);
    }

    private void print2(Element e) {
        int startLine = currentLine;
        int startColumn = currentColumn;
        e.match(this);
        sourcePositions.put(e, new SourcePosition("",
                startLine, startColumn, currentLine, currentColumn));
    }

    private Type tryCalculateType(Operand variable) {
        try {
            return variable.calculateType();
        } catch (Throwable t) {
            return null;
        }
    }

    private Type tryCalculateType(Variable variable) {
        try {
            return variable.calculateType();
        } catch (Throwable t) {
            return null;
        }
    }

    private void append(Object o) {
        String s = o.toString();
        currentColumn += s.length();
        sb.append(o);
    }

    private void appendLine() {
        sb.append("\n");
        currentLine++;
        currentColumn = 0;
    }

    private void appendLine(Object o) {
        sb.append(o);
        appendLine();
    }

    @Override
    public void case_PhiNodeChoice(PhiNodeChoice choice) {
        append("[ ");
        print(choice.getValue());
        append(", %" + getName(choice.getLabel()));
        append(" ]");
    }

    @Override
    public void case_PhiNode(PhiNode e) {
        append(e.getVar() + " = phi " + e.getType() + " ");
        boolean first = true;
        for (PhiNodeChoice choice : e.getChoices()) {
            if (!first) {
                append(", ");
            }
            append("[ ");
            print(choice.getValue());
            append(", %" + getName(choice.getLabel()));
            append(" ]");
            first = false;
        }
    }

    @Override
    public void case_BasicBlock(BasicBlock e) {
        appendLine(getName(e) + ":");
        append("    ");
        for (Instruction i : e) {
            print(i);
            appendLine();
            append("    ");
        }
        appendLine("");
    }

    @Override
    public void case_Proc(Proc proc) {
        append("define " + proc.getReturnType() + " @" + getName(proc) + "(");
        boolean first = true;
        for (Parameter p : proc.getParameters()) {
            if (!first) {
                append(", ");
            }
            append(p.getType());
            append(" ");
            append(p);
            first = false;
        }
        appendLine(") {");
        for (BasicBlock b : proc.getBasicBlocks()) {
            print(b);
        }
        appendLine();
        appendLine("}");
        appendLine();
    }

    @Override
    public void case_Global(Global g) {
        append("@" + getName(g) + " = ");
        if (g.getIsConstant()) {
            append("constant ");
        } else {
            append("global ");
        }
        append(elementToString(g.getType()) + " ");
        print(g.getInitialValue());
    }

    @Override
    public void case_TemporaryVar(TemporaryVar e) {
        append("%" + getName(e));
    }

    @Override
    public void case_Parameter(Parameter e) {
        append("%" + getName(e));
    }

    @Override
    public void case_Prog(Prog p) {
        // before printing a program, eliminate all duplicate names
        DuplicateNames.eliminateDuplicateNames(p);

        printStringConstants(p);

        appendLine();
        appendLine();

        for (TypeStruct s : p.getStructTypes()) {
            print(s);
            appendLine();
            appendLine();
        }

        for (Global g : p.getGlobals()) {
            print(g);
            appendLine();
            appendLine();
        }

        for (Proc proc : p.getProcedures()) {
            print(proc);
        }

        addBuiltins();
    }

    private void printStringConstants(Prog p) {
        p.accept(new Element.DefaultVisitor() {
            int messageNr = 0;

            public void visit(HaltWithError e) {
                super.visit(e);
                if (stringConstantNames.containsKey(e.getMsg())) {
                    // already has constant for this string
                    return;
                }
                // print constant for string
                messageNr++;
                String constantName = ".print_message_" + messageNr;
                byte[] bytes = e.getMsg().getBytes();

                appendLine("@" + constantName + " = private unnamed_addr constant ["
                        + (bytes.length + 2)
                        + " x i8] c" + escapeString(e.getMsg() + "\n\0") + ", align 1");
                stringConstantNames.put(e.getMsg(), constantName);
            }
        });
    }

    /**
     * special code for builtin functions like print.
     */
    private void addBuiltins() {
        appendLine();
        appendLine("declare noalias i8* @malloc(i32)");
        appendLine();
        appendLine("declare i32 @printf(i8*, ...)");
        appendLine();
        appendLine("declare void @exit(i32)");
        appendLine();
        appendLine("@.printstr = private unnamed_addr constant [4 x i8] c\"%d\\0A\\00\", align 1");
        appendLine("define void @print(i32 %i) {");
        appendLine("    %temp = call i32 (i8*, ...) "
                + "@printf(i8* getelementptr inbounds "
                + "([4 x i8], [4 x i8]* @.printstr, i32 0, i32 0), i32 %i)");
        appendLine("    ret void");
        appendLine("}");
    }

    @Override
    public void case_Sizeof(Sizeof e) {
        if (includeType) {
            append("i32 ");
        }
        append("ptrtoint (%" + getName(e.getStructType()) + "* getelementptr (%"
                + getName(e.getStructType()) + ", %"
                + getName(e.getStructType()) + "* null, i32 1) to i32)");
    }

    @Override
    public void case_Nullpointer(Nullpointer e) {
        if (includeType) {
            // TODO print type
            append(ExpectedType.expectedType(e) + " ");
        }
        append("null");
    }

    @Override
    public void case_ConstInt(ConstInt e) {
        if (includeType) {
            append("i32 ");
        }
        append(e.getIntVal());
    }

    @Override
    public void case_ConstBool(ConstBool e) {
        if (includeType) {
            append("i1 ");
        }
        append(e.getBoolVal() ? 1 : 0);
    }

    @Override
    public void case_VarRef(VarRef e) {
        if (includeType) {
            append(tryCalculateType(e.getVariable()) + " ");
        }
        append(e.getVariable());
    }

    @Override
    public void case_ParameterList(ParameterList parameterList) {
        printList(parameterList, ", ");
    }

    @Override
    public void case_ProcedureRef(ProcedureRef e) {
        if (includeType) {
            append(Ast.TypePointer(procedureType(e.getProcedure())));
            append(" ");
        }
        append("@" + getName(e.getProcedure()));
    }

    private Type procedureType(Proc procedure) { // TODO do somewhere else?
        Type resultType = procedure.getReturnType();
        TypeRefList argTypes = Ast.TypeRefList();
        for (Parameter p : procedure.getParameters()) {
            argTypes.add(p.getType());
        }
        return Ast.TypeProc(argTypes, resultType);
    }

    @Override
    public void case_GlobalRef(GlobalRef e) {
        if (includeType) {
            append(Ast.TypePointer(e.getGlobal().getType()));
            append(" ");
        }
        append("@" + getName(e.getGlobal()));
    }

    @Override
    public void case_ConstStruct(ConstStruct e) {
        appendLine(" {");
        append("    ");
        boolean first = true;
        for (minillvm.ast.Const val : e.getValues()) {
            if (!first) {
                appendLine(",");
                append("    ");
            }
            printWithType(val);
            first = false;
        }
        appendLine();
        appendLine("}");
    }


    @Override
    public void case_ReturnVoid(ReturnVoid s) {
        append("ret void");
    }

    @Override
    public void case_StructField(StructField structField) {
        throw new RuntimeException();
    }

    @Override
    public void case_Branch(Branch s) {
        append("br ");
        printWithType(s.getCondition());
        append(", label %" + getName(s.getIfTrueLabel()));
        append(", label %" + getName(s.getIfFalseLabel()));
    }

    @Override
    public void case_ReturnExpr(ReturnExpr s) {
        append("ret ");
        printWithType(s.getReturnValue());
    }

    @Override
    public void case_Jump(Jump s) {
        append("br label %" + getName(s.getLabel()));
    }

    @Override
    public void case_Bitcast(Bitcast s) {
        append(s.getVar() + " = bitcast ");
        printWithType(s.getExpr());
        append(" to " + s.getType());
    }

    @Override
    public void case_BinaryOperation(BinaryOperation s) {
        append(s.getVar() + " = ");
        if (Typechecker.isComparison(s.getOperator())) {
            append("icmp " + s.getOperator() + " ");
            printWithType(s.getLeft());
        } else {
            append(s.getOperator() + " " + tryCalculateType(s.getVar()) + " ");
            print(s.getLeft());
        }
        append(", ");
        print(s.getRight());
    }


    @Override
    public void case_GetElementPtr(GetElementPtr s) {
        Type t = tryCalculateType(s.getBaseAddress());
        if (t instanceof TypePointer) {
            t = ((TypePointer) t).getTo();
        }
        append(s.getVar() + " = getelementptr " + t + ", ");
        // TODO type
        printWithType(s.getBaseAddress());
        for (Operand ind : s.getIndices()) {
            append(", ");
            printWithType(ind);
        }
    }


    @Override
    public void case_Load(Load s) {
        Type t;
        Type addressType = tryCalculateType(s.getAddress());
        if (addressType instanceof TypePointer) {
            t = ((TypePointer) addressType).getTo();
        } else {
            t = Ast.TypeByte();
        }
        append(s.getVar() + " = load " + t + ", ");
        printWithType(s.getAddress());
    }

    @Override
    public void case_HaltWithError(HaltWithError s) {
        appendLine("; ERROR: " + s.getMsg()
                .replaceAll("[\r\n]", " | ") + "");
        appendLine("    call i32 (i8*, ...) @printf(i8* getelementptr inbounds (["
                + (s.getMsg().getBytes().length + 2) + " x i8], ["
                + (s.getMsg().getBytes().length + 2) + " x i8]* @"
                + stringConstantNames.get(s.getMsg()) + ", i32 0, i32 0))");

        appendLine("    call void @exit(i32 222)");
        appendLine("    unreachable");
    }

    @Override
    public void case_Alloc(Alloc s) {
        append(s.getVar() + " = call i8* @malloc(");
        printWithType(s.getSizeInBytes());
        append(")");
    }

    @Override
    public void case_TypeNullpointer(TypeNullpointer typeNullpointer) {
        // should never be printed
        append("nullpointer");
    }

    @Override
    public void case_Store(Store s) {
        append("store ");
        printWithType(s.getValue());
        append(", ");
        printWithType(s.getAddress());
    }

    @Override
    public void case_Call(Call s) {
        Type t = tryCalculateType(s.getFunction());
        if (t instanceof TypePointer) {
            TypePointer funcPointerType = (TypePointer) tryCalculateType(s.getFunction());
            if (funcPointerType.getTo() instanceof TypeProc) {
                TypeProc procType = (TypeProc) funcPointerType.getTo();
                t = procType.getResultType();
            }
        }


        append(s.getVar() + " = ");
        append("call " + t + " ");

        print(s.getFunction());
        append("(");
        boolean first = true;
        for (Operand arg : s.getArguments()) {
            if (!first) {
                append(", ");
            }
            printWithType(arg);
            first = false;
        }
        append(")");
    }

    @Override
    public void case_Print(Print s) {
        append("call void @print(");
        printWithType(s.getE());
        append(")");
    }


    @Override
    public void case_TypeArray(TypeArray t) {
        append("[" + t.getSize() + " x " + t.getOf() + "]");
    }

    @Override
    public void case_TypePointer(TypePointer t) {
        append(t.getTo() + "*");
    }

    @Override
    public void case_StructFieldList(StructFieldList structFieldList) {
        throw new RuntimeException();
    }

    @Override
    public void case_TypeVoid(TypeVoid t) {
        append("void");
    }

    @Override
    public void case_TypeStruct(TypeStruct t) {
        append("%" + getName(t) + " = type {");
        boolean first = true;
        for (StructField ta : t.getFields()) {
            appendLine();
            append("    ");
            if (!first) {
                append(",");
            } else {
                append(" ");
            }
            append(ta.getType());
            append("  ; ");
            append(ta.getName());
            first = false;
        }
        appendLine();
        append("}");
    }

    @Override
    public void case_TypeInt(TypeInt t) {
        append("i32");
    }

    @Override
    public void case_TypeByte(TypeByte t) {
        append("i8");
    }

    @Override
    public void case_TypeBool(TypeBool t) {
        append("i1");
    }

    @Override
    public void case_TypeProc(TypeProc t) {
        append(t.getResultType() + "(");
        boolean first = true;
        for (Type at : t.getArgTypes()) {
            if (!first) {
                append(", ");
            }
            append(at);
            first = false;
        }
        append(")");
    }

    @Override
    public void case_Sub(Sub sub) {
        append("sub");
    }

    @Override
    public void case_Mul(Mul mul) {
        append("mul");
    }

    @Override
    public void case_Srem(Srem srem) {
        append("srem");
    }

    @Override
    public void case_Or(Or or) {
        append("or");
    }

    @Override
    public void case_Eq(Eq eq) {
        append("eq");
    }

    @Override
    public void case_Slt(Slt slt) {
        append("slt");
    }

    @Override
    public void case_And(And and) {
        append("and");
    }

    @Override
    public void case_Xor(Xor xor) {
        append("xor");
    }

    @Override
    public void case_Add(Add add) {
        append("add");
    }

    @Override
    public void case_CommentInstr(CommentInstr commentInstr) {
        String[] lines = commentInstr.getText().split("[\r\n]+");
        for (int i = 0; i < lines.length; i++) {
            if (i > 0) {
                appendLine();
                append("    ");
            }
            append(";");
            append(lines[i]);
        }
    }

    @Override
    public void case_Sdiv(Sdiv sdiv) {
        append("sdiv");
    }


    @Override
    public void case_OperandList(OperandList l) {
        printList(l, ", ");
    }

    @Override
    public void case_PhiNodeList(PhiNodeList l) {
        printList(l, ", ");
    }

    @Override
    public void case_TypeRefList(TypeRefList l) {
        printList(l, ", ");
    }

    @Override
    public void case_ProcList(ProcList l) {
        printList(l, ", ");
    }

    @Override
    public void case_InstructionList(InstructionList l) {
        printList(l, ", ");
    }


    @Override
    public void case_BasicBlockList(BasicBlockList l) {
        printList(l, ", ");
    }

    @Override
    public void case_PhiNodeChoiceList(PhiNodeChoiceList l) {
        printList(l, ", ");
    }

    @Override
    public void case_ConstList(ConstList l) {
        printList(l, ", ");
    }

    @Override
    public void case_GlobalList(GlobalList l) {
        printList(l, ", ");
    }

    @Override
    public void case_TypeStructList(TypeStructList l) {
        printList(l, ", ");
    }

    private <T extends Element> void printList(List<T> l, String sep) {
        boolean first = true;
        for (T t : l) {
            if (first) {
                append(sep);
            }
            print(t);
            first = false;
        }
    }

    @Override
    public void case_Alloca(Alloca s) {
        append(s.getVar() + " = alloca " + s.getType());
    }

    public Map<Element, SourcePosition> getSourcePositions() {
        return sourcePositions;
    }
}
