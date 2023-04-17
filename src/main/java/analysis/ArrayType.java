package analysis;

import notquitejava.ast.NQJExpr;

/** Array extension for types. */
public class ArrayType extends Type {
    public final Type baseType;

    public ArrayType(Type baseType) {
        this.baseType = baseType;
    }

    @Override
    boolean isSubtypeOf(Type other) {
        if (other instanceof ArrayType) {
            ArrayType ct = (ArrayType) other;
            return baseType.isSubtypeOf(ct.baseType);
        }
        return other == ANY;
    }

    @Override
    public String toString() {
        return baseType.toString() + "[]";
    }

    public Type getBaseType() {
        return baseType;
    }
}
