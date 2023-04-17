package analysis;

import notquitejava.ast.NQJFunctionDecl;

import java.util.Map;

/** Type extension for interfaces. */
public class InterfaceType extends Type {
    /**
     * The name of the interface.
     */
    private String name;

    /**
     * Represents the function declarations of the interface.
     * It is a mapping of function names and function declarations.
     * Note: interface function declarations do not have a body (i.e. it is null)
     */
    private Map<String, NQJFunctionDecl> functions;

    private ClassType classImplementation;

    public InterfaceType(String interfaceName, Map<String, NQJFunctionDecl> functions) {
        this.name = interfaceName;
        this.functions = functions;
    }

    public Map<String, NQJFunctionDecl> getFunctions() {
        return functions;
    }

    public String getName() {
        return this.name;
    }

    public NQJFunctionDecl getFunction(String name) {
        return functions.get(name);
    }

    @Override
    boolean isSubtypeOf(Type other) {
        if (other instanceof InterfaceType) {
            return ((InterfaceType) other).getName().equals(this.name);
        }
        return ANY == other;
    }

    public void setClassImplementation(ClassType classImplementation) {
        this.classImplementation = classImplementation;
    }

    public ClassType getClassImplementation() {
        return classImplementation;
    }
}
