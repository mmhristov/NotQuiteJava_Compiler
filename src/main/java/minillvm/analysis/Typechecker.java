package minillvm.analysis;


import minillvm.ast.*;

import java.util.LinkedHashSet;
import java.util.Set;

/**
 * Type checker for LLVM.
 */
public class Typechecker {
    public static Type calculateType(Operand op) {
        return calculateType(op, new LinkedHashSet<>());
    }

    private static Type calculateType(Operand op, Set<Element> visited) {
        if (!visited.add(op)) {
            throw new LlvmTypeErrorCycle(visited);
        }
        return op.match(new Operand.Matcher<>() {
            @Override
            public Type case_Sizeof(Sizeof o) {
                return Ast.TypeInt();
            }

            @Override
            public Type case_VarRef(VarRef o) {
                visited.add(o);
                return calculateType(o.getVariable(), visited);
            }

            @Override
            public Type case_ConstStruct(ConstStruct o) {
                return o.getStructType();
            }

            @Override
            public Type case_Nullpointer(Nullpointer o) {
                return Ast.TypeNullpointer();
            }

            @Override
            public Type case_ProcedureRef(ProcedureRef o) {
                Proc proc = o.getProcedure();
                TypeRefList types = Ast.TypeRefList();

                for (Parameter v : proc.getParameters()) {
                    types.add(v.getType());
                }

                return Ast.TypePointer(Ast.TypeProc(types,
                        proc.getReturnType()));
            }

            @Override
            public Type case_ConstInt(ConstInt o) {
                return Ast.TypeInt();
            }

            @Override
            public Type case_GlobalRef(GlobalRef o) {
                return Ast.TypePointer(o.getGlobal().getType());
            }

            @Override
            public Type case_ConstBool(ConstBool o) {
                return Ast.TypeBool();
            }
        });
    }


    public static Type calculateType(Parameter parameter) {
        return parameter.getType();
    }

    public static Type calculateType(Variable t) {
        return calculateType(t, new LinkedHashSet<>());
    }

    /** Type calc. */
    public static Type calculateType(Variable t, Set<Element> visited) {
        return t.match(new Variable.Matcher<>() {
            @Override
            public Type case_Parameter(Parameter parameter) {
                return parameter.getType();
            }

            @Override
            public Type case_TemporaryVar(TemporaryVar temporaryVar) {
                return calculateType(temporaryVar, visited);
            }
        });
    }

    /** Type calc. */
    public static Type calculateType(TemporaryVar t, Set<Element> visited) {
        Element parent = t.getParent();
        if (parent == null) {
            // unknown
            return Ast.TypeByte();
        }
        visited.add(parent);
        if (parent instanceof Assign) {
            return ((Assign) parent).match(new Assign.Matcher<>() {
                @Override
                public Type case_Alloc(Alloc alloc) {
                    return Ast.TypePointer(Ast.TypeByte());
                }

                @Override
                public Type case_Call(Call call) {
                    Type funcType = calculateType(call.getFunction(), visited);
                    return returnTypeOfProcPointer(funcType);
                }

                @Override
                public Type case_Load(Load load) {
                    Type addressType = calculateType(load.getAddress(), visited);
                    if (addressType instanceof TypePointer) {
                        return ((TypePointer) addressType).getTo();
                    }
                    // error case:
                    return addressType;
                }

                @Override
                public Type case_Bitcast(Bitcast bitcast) {
                    return bitcast.getType();
                }

                @Override
                public Type case_BinaryOperation(BinaryOperation binOp) {
                    Operator op = binOp.getOperator();
                    if (isComparison(op)) {
                        return Ast.TypeBool();
                    }
                    // other operators return the same type as the arguments
                    return calculateType(binOp.getLeft(), visited);
                }

                @Override
                public Type case_Alloca(Alloca alloca) {
                    return Ast.TypePointer(alloca.getType());
                }

                @Override
                public Type case_GetElementPtr(GetElementPtr gep) {
                    Type ba = calculateType(gep.getBaseAddress(), visited);
                    if (ba instanceof TypePointer) {
                        Type t = ((TypePointer) ba).getTo();
                        for (int i = 1; i < gep.getIndices().size(); i++) {
                            Operand index = gep.getIndices().get(i);
                            if (t instanceof TypeArray) {
                                t = ((TypeArray) t).getOf();
                            } else if (t instanceof TypeStruct) {
                                TypeStruct struct = (TypeStruct) t;
                                if (index instanceof ConstInt) {
                                    int indexNr = ((ConstInt) index).getIntVal();
                                    if (indexNr >= 0 && indexNr < struct.getFields().size()) {
                                        t = struct.getFields().get(indexNr).getType();
                                    }
                                }
                            }
                        }
                        return Ast.TypePointer(t);
                    }
                    // unknown
                    return Ast.TypeByte();
                }

                @Override
                public Type case_PhiNode(PhiNode phiNode) {
                    return phiNode.getType();
                }
            });
        }
        throw new RuntimeException("unhandled case: " + parent.getClass().getSimpleName());
    }

    private static Type returnTypeOfProcPointer(Type funcPointerType) {
        if (funcPointerType instanceof TypePointer) {
            TypePointer funcType = (TypePointer) funcPointerType;
            if (funcType.getTo() instanceof TypeProc) {
                TypeProc procType = (TypeProc) funcType.getTo();
                return procType.getResultType();
            }
        }
        // unknown
        return Ast.TypeByte();
    }

    public static boolean isComparison(Operator operator) {
        return operator instanceof Eq
                || operator instanceof Slt;
    }

    public static boolean equalsType(TypeByte t, Type other) {
        return other instanceof TypeByte;
    }

    public static boolean equalsType(TypeVoid t, Type other) {
        return other instanceof TypeVoid;
    }

    public static boolean equalsType(TypeInt t, Type other) {
        return other instanceof TypeInt;
    }

    /** Equals. */
    public static boolean equalsType(TypePointer t, Type other) {
        if (other instanceof TypePointer) {
            return t.getTo().equalsType(((TypePointer) other).getTo());
        }
        return false;
    }

    /** Equals. */
    public static boolean equalsType(TypeArray t, Type other) {
        if (other instanceof TypeArray) {
            TypeArray ar = (TypeArray) other;
            return t.getOf().equalsType(ar.getOf())
                    && t.getSize() == ar.getSize();

        }
        return false;
    }

    /** Equals. */
    public static boolean equalsType(TypeProc t, Type other) {
        if (other instanceof TypeProc) {
            TypeProc tp = (TypeProc) other;
            if (!t.getResultType().equalsType(tp.getResultType())) {
                return false;
            }
            if (t.getArgTypes().size() != tp.getArgTypes().size()) {
                return false;
            }
            for (int i = 0; i < t.getArgTypes().size(); i++) {
                if (!t.getArgTypes().get(i).equalsType(tp.getArgTypes().get(i))) {
                    return false;
                }
            }
            return true;
        }
        return false;
    }

    public static boolean equalsType(TypeNullpointer t, Type other) {
        return other instanceof TypeNullpointer;
    }

    public static boolean equalsType(TypeStruct t, Type other) {
        return t == other;
    }

    public static boolean equalsType(TypeBool t, Type other) {
        return other instanceof TypeBool;
    }

}

