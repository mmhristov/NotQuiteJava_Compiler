package analysis;

import notquitejava.ast.NQJFunctionDecl;
import notquitejava.ast.NQJVarDecl;

import java.util.List;
import java.util.Map;

/** Type extension for classes. */
public class ClassType extends Type {
    /**
     * The name of the class.
     */
    private final String name;
    /**
     * Represents the direct super class of this class.
     */
    private ClassType superClass;

    /**
     * Represents the interface that the class implements.
     */
    private List<InterfaceType> implementsInterfaces;

    /**
     * Represents the fields of the class.
     * It is a mapping of field names and var declarations.
     */
    private Map<String, NQJVarDecl> fields;

    /**
     * Represents the function declarations of the class.
     * It is a mapping of function names and function declarations.
     */
    private Map<String, NQJFunctionDecl> methods;

    /**
     * Constructor for class types.
     *
     * @param name the name of the class
     * @param superClass the direct super-class
     * @param implementsInterfaces the list of interface-types it implements
     * @param fields the list of fields
     * @param methods the list of methods
     */
    public ClassType(
            String name,
            ClassType superClass, List<InterfaceType> implementsInterfaces,
            Map<String, NQJVarDecl> fields, Map<String, NQJFunctionDecl> methods) {
        this.name = name;
        this.superClass = superClass;
        this.implementsInterfaces = implementsInterfaces;
        this.fields = fields;
        this.methods = methods;
    }

    public String getName() {
        return this.name;
    }

    public ClassType getSuperClass() {
        return this.superClass;
    }

    public Map<String, NQJVarDecl> getFields() {
        return this.fields;
    }

    public Map<String, NQJFunctionDecl> getMethods() {
        return this.methods;
    }

    @Override
    boolean isSubtypeOf(Type other) {
        if (other instanceof  ClassType) {
            if (other == this) {
                return true;
            }
            return checkIfOtherIsParent((ClassType) other);
        } else if (other instanceof InterfaceType) {
            return this.implementsInterfaces.contains(other);
        } else {
            return ANY == other;
        }
    }

    /**
     * Recursively checks whether the current class's parent implements the parameter class.
     */
    private boolean checkIfOtherIsParent(ClassType other) {
        ClassType parent = this.superClass;
        if (parent != null) {
            if (parent == other) {
                return true;
            } else {
                return parent.checkIfOtherIsParent(other);
            }
        } else {
            return false;
        }
    }

    @Override
    public String toString() {
        return this.getName();
    }

    /**
     * Retrieves the variable declaration of the class' field named varName.
     *
     * @param varName the name of the field to be returned
     * @return the field of the class with name varName if it exists. Null otherwise
     */
    public NQJVarDecl getField(String varName) {
        return fields.get(varName);
    }

    /**
     * Retrieves the function declaration of the class' function names methodName.
     *
     * @param methodName the name of the method
     * @return the function of the class with name methodName if it exists, Null otherwise
     */
    public NQJFunctionDecl getMethod(String methodName) {
        return methods.get(methodName);
    }
}
