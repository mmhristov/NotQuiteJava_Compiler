package analysis;

import java.util.HashMap;
import java.util.Map;
import notquitejava.ast.NQJVarDecl;

/**
 * Implementation of a variable type context.
 * Manages VariableReferences, return types, this types.
 */
public class TypeContextImpl implements TypeContext {
    private final Map<String, VarRef> env;
    private Type returnType;
    private Type thisType;

    /**
     * Saves reference to the env map constructor.
     */
    public TypeContextImpl(Map<String, VarRef> env, Type returnType, Type thisType) {
        this.env = env;
        this.returnType = returnType;
        this.thisType = thisType;
    }

    /**
     * Creates a new empty context with given return and this type.
     */
    public TypeContextImpl(Type returnType, Type thisType) {
        this.env = new HashMap<>();
        this.returnType = returnType;
        this.thisType = thisType;
    }

    @Override
    public Type getReturnType() {
        return returnType;
    }

    @Override
    public Type getThisType() {
        return thisType;
    }

    @Override
    public VarRef lookupVar(String varUse) {
        return env.get(varUse);
    }

    @Override
    public void putVar(String varName, Type type, NQJVarDecl var) {
        this.env.put(varName, new VarRef(type, var));
    }

    @Override
    public TypeContext copy() {
        return new TypeContextImpl(new HashMap<>(this.env), this.returnType, this.thisType);
    }

    @Override
    public void setThisType(Type thisType) {
        this.thisType = thisType;
    }

    @Override
    public void setReturnType(Type returnType) {
        this.returnType = returnType;
    }

}
