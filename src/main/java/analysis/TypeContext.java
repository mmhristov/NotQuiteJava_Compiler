package analysis;

import notquitejava.ast.NQJVarDecl;

/**
 * Type context for variable look ups.
 */
public interface TypeContext {
    Type getReturnType();

    Type getThisType();

    void setThisType(Type thisType);

    void setReturnType(Type returnType);

    VarRef lookupVar(String varUse);

    void putVar(String varName, Type type, NQJVarDecl var);

    TypeContext copy();

    /**
     * Variable declaration and type wrapper class.
     */
    class VarRef {
        final NQJVarDecl decl;
        final Type type;

        public VarRef(Type type, NQJVarDecl decl) {
            this.decl = decl;
            this.type = type;
        }

        public NQJVarDecl getVarDecl() {
            return decl;
        }
    }
}
