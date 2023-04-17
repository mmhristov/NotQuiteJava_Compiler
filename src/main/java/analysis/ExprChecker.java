package analysis;

import analysis.TypeContext.VarRef;
import notquitejava.ast.*;

/**
 * Matcher implementation for expressions returning a NQJ type.
 */
public class ExprChecker implements NQJExpr.Matcher<Type>, NQJExprL.Matcher<Type> {
    private final Analysis analysis;
    private final TypeContext ctxt;

    public ExprChecker(Analysis analysis, TypeContext ctxt) {
        this.analysis = analysis;
        this.ctxt = ctxt;
    }

    Type check(NQJExpr e) {
        return e.match(this);
    }

    Type check(NQJExprL e) {
        return e.match(this);
    }

    void expect(NQJExpr e, Type expected) {
        Type actual = check(e);
        if (!actual.isSubtypeOf(expected)) {
            analysis.addError(e, "Expected expression of type " + expected
                    + " but found " + actual + ".");
        }
    }

    Type expectArray(NQJExpr e) {
        Type actual = check(e);
        if (!(actual instanceof ArrayType)) {
            analysis.addError(e, "Expected expression of array type,  but found " + actual + ".");
            return Type.ANY;
        } else {
            return actual;
        }
    }

    @Override
    public Type case_ExprUnary(NQJExprUnary exprUnary) {
        Type t = check(exprUnary.getExpr());
        return exprUnary.getUnaryOperator().match(new NQJUnaryOperator.Matcher<Type>() {

            @Override
            public Type case_UnaryMinus(NQJUnaryMinus unaryMinus) {
                expect(exprUnary.getExpr(), Type.INT);
                return Type.INT;
            }

            @Override
            public Type case_Negate(NQJNegate negate) {
                expect(exprUnary.getExpr(), Type.BOOL);
                return Type.BOOL;
            }
        });
    }

    @Override
    public Type case_MethodCall(NQJMethodCall methodCall) {
        String methodName = methodCall.getMethodName();
        NQJExpr receiver = methodCall.getReceiver();
        Type recType = check(receiver);

        NQJFunctionDecl method;
        String name;

        Type fallback = Type.ANY; // prevents further errors
        // check if the type of the receiver is a class or interface and throw errors accordingly
        if (recType instanceof ClassType) {
            ClassType classType = (ClassType) recType;
            name = classType.getName();
            // check if the method exists in class
            method = classType.getMethod(methodName);

            if (method == null) {
                analysis.addError(methodCall,
                        "Method with name " + methodName
                                + " of class " + classType.getName()
                                + " was not found"
                );
                return fallback;
            }
        } else if (recType instanceof InterfaceType) {
            InterfaceType interfaceType = (InterfaceType) recType;
            name = interfaceType.getName();
            // check if the method exists in interface
            method = interfaceType.getFunction(methodName);

            if (method == null) {
                analysis.addError(methodCall,
                        "Method with name " + methodName
                                + " of class " + interfaceType.getName()
                                + " was not found"
                );
                return fallback;
            }
        } else {
            analysis.addError(methodCall,
                    "Receiver of type "
                            + recType.toString()
                            + " was not found");
            return fallback;
        }

        // method found in either class or interface

        // add errors if arguments and parameters do not match
        verifyFunctionCallArguments(
                methodCall,
                methodCall.getArguments(),
                method.getFormalParameters()
        );
        methodCall.setFunctionDeclaration(method); // needed for translation phase
        return analysis.type(method.getReturnType());
    }


    @Override
    public Type case_ArrayLength(NQJArrayLength arrayLength) {
        expectArray(arrayLength.getArrayExpr());
        return Type.INT;
    }

    @Override
    public Type case_ExprThis(NQJExprThis exprThis) {
        return this.ctxt.getThisType();
    }

    @Override
    public Type case_ExprBinary(NQJExprBinary exprBinary) {
        return exprBinary.getOperator().match(new NQJOperator.Matcher<>() {
            @Override
            public Type case_And(NQJAnd and) {
                expect(exprBinary.getLeft(), Type.BOOL);
                expect(exprBinary.getRight(), Type.BOOL);
                return Type.BOOL;
            }

            @Override
            public Type case_Times(NQJTimes times) {
                return case_intOperation();
            }

            @Override
            public Type case_Div(NQJDiv div) {
                return case_intOperation();
            }

            @Override
            public Type case_Plus(NQJPlus plus) {
                return case_intOperation();
            }

            @Override
            public Type case_Minus(NQJMinus minus) {
                return case_intOperation();
            }

            private Type case_intOperation() {
                expect(exprBinary.getLeft(), Type.INT);
                expect(exprBinary.getRight(), Type.INT);
                return Type.INT;
            }

            @Override
            public Type case_Equals(NQJEquals equals) {
                Type l = check(exprBinary.getLeft());
                Type r = check(exprBinary.getRight());
                if (!l.isSubtypeOf(r) && !r.isSubtypeOf(l)) {
                    analysis.addError(exprBinary, "Cannot compare types " + l + " and " + r + ".");
                }
                return Type.BOOL;
            }

            @Override
            public Type case_Less(NQJLess less) {
                expect(exprBinary.getLeft(), Type.INT);
                expect(exprBinary.getRight(), Type.INT);
                return Type.BOOL;
            }
        });
    }

    @Override
    public Type case_ExprNull(NQJExprNull exprNull) {
        return Type.NULL;
    }

    @Override
    public Type case_FunctionCall(NQJFunctionCall functionCall) {
        NQJFunctionDecl m = analysis.getNameTable().lookupFunction(functionCall.getMethodName());
        if (m == null) {
            analysis.addError(functionCall, "Function " + functionCall.getMethodName()
                    + " does not exist.");
            return Type.ANY;
        }
        NQJExprList args = functionCall.getArguments();
        NQJVarDeclList params = m.getFormalParameters();
        verifyFunctionCallArguments(functionCall, args, params);
        functionCall.setFunctionDeclaration(m);
        return analysis.type(m.getReturnType());
    }

    /**
     * Check if arguments and parameters of a function- or method-call match up.
     *
     * @param functionCall the function call object. Used in error message generation
     * @param args the required list of arguments of the function
     * @param params the provided parameters to the function call
     */
    private void verifyFunctionCallArguments(
            NQJElement functionCall,
            NQJExprList args,
            NQJVarDeclList params) {
        if (args.size() < params.size()) {
            analysis.addError(functionCall, "Not enough arguments.");
        } else if (args.size() > params.size()) {
            analysis.addError(functionCall, "Too many arguments.");
        } else {
            for (int i = 0; i < params.size(); i++) {
                expect(args.get(i), analysis.type(params.get(i).getType()));
            }
        }
    }

    @Override
    public Type case_Number(NQJNumber number) {
        return Type.INT;
    }

    @Override
    public Type case_NewArray(NQJNewArray newArray) {
        expect(newArray.getArraySize(), Type.INT);
        NQJType baseType = newArray.getBaseType();
        ArrayType t = new ArrayType(analysis.type(baseType));
        // verify sizes of sub-arrays
        if (baseType instanceof NQJTypeArray) { // no nullpointer check needed
            NQJTypeArray subArray = (NQJTypeArray) baseType;
            while (subArray != null) {
                expect(subArray.getDimension(), Type.INT);
                NQJType ct = subArray.getComponentType();
                subArray = (ct instanceof NQJTypeArray) ? (NQJTypeArray) ct : null;
            }
        }
        newArray.setArrayType(t);
        return t;
    }

    @Override
    public Type case_NewObject(NQJNewObject newObject) {
        String className = newObject.getClassName();
        Type classType = analysis.getNameTable().getClassType(className);
        if (classType == Type.ANY) {
            this.analysis.addError(newObject,
                    "Class declaration for " + className + " is not found");
            return Type.ANY;
        }

        return classType;
    }

    @Override
    public Type case_BoolConst(NQJBoolConst boolConst) {
        return Type.BOOL;
    }

    @Override
    public Type case_Read(NQJRead read) {
        return read.getAddress().match(this);
    }

    @Override
    public Type case_FieldAccess(NQJFieldAccess fieldAccess) {
        String fieldName = fieldAccess.getFieldName();
        NQJExpr receiver = fieldAccess.getReceiver();
        Type recType = check(receiver);

        Type fallback = Type.ANY; // prevents further errors
        if (!(recType instanceof ClassType)) {
            analysis.addError(fieldAccess,
                    "Receiver of type " + recType.toString() + " is not a class");
            return fallback;
        }

        // receiver's type is ClassType
        ClassType classType = (ClassType) recType;
        NQJVarDecl field = classType.getField(fieldName);
        if (field == null) {
            // field not found in class
            analysis.addError(
                    fieldAccess,
                    "Field with name " + fieldName
                            + " not found in class " + classType.getName()
            );
            return fallback;
        }

        // field found in class
        return analysis.type(field.getType());
    }

    @Override
    public Type case_VarUse(NQJVarUse varUse) {
        VarRef ref = ctxt.lookupVar(varUse.getVarName());
        if (ref == null) {
            analysis.addError(varUse, "Variable " + varUse.getVarName() + " is not defined.");
            return Type.ANY;
        }
        varUse.setVariableDeclaration(ref.decl);
        return ref.type;
    }

    @Override
    public Type case_ArrayLookup(NQJArrayLookup arrayLookup) {
        Type type = check(arrayLookup.getArrayExpr());
        expect(arrayLookup.getArrayIndex(), Type.INT);
        if (type instanceof ArrayType) {
            ArrayType arrayType = (ArrayType) type;
            arrayLookup.setArrayType(arrayType);
            return arrayType.getBaseType();
        }
        analysis.addError(arrayLookup, "Expected an array for array-lookup, but found " + type);
        return Type.ANY;
    }
}
