package analysis;

import java.util.*;

import notquitejava.ast.*;

/**
 * Name table for analysis class hierarchies.
 */
public class NameTable {
    /**
     * A cache that maps base types to their respective ArrayType objects.
     */
    private final Map<Type, ArrayType> arrayTypes = new HashMap<>();

    /**
     * A cache that maps names of classes to their respective ClassType objects.
     */
    private final Map<String, ClassType> classTypes = new HashMap<>(); // similar to arrayTypes map

    /**
     * A cache that maps names of interfaces to their respective InterfaceType objects.
     */
    // similar to classTypes map
    private final Map<String, InterfaceType> interfaceTypes = new HashMap<>();

    private final Map<String, NQJFunctionDecl> globalFunctions = new HashMap<>();

    /**
     * A map of all globally defined classes.
     * Key: class name (string), Value: declaration (NQJClassDecl).
     */
    private final Map<String, NQJClassDecl> globalClasses = new HashMap<>();

    /**
     * A map of all globally defined interfaces.
     * Key: interface name (string), Value: interface declaration (NQJClassDecl)
     */
    private final Map<String, NQJInterfaceDecl> globalInterfaces = new HashMap<>();

    private final Analysis analysis;

    NameTable(Analysis analysis, NQJProgram prog) {
        this.analysis = analysis;
        globalFunctions.put("printInt", NQJ.FunctionDecl(NQJ.TypeInt(), "main",
                NQJ.VarDeclList(NQJ.VarDecl(NQJ.TypeInt(), "elem")), NQJ.Block()));

        // add global function declarations
        for (NQJFunctionDecl f : prog.getFunctionDecls()) {
            var old = globalFunctions.put(f.getName(), f);
            if (old != null) {
                analysis.addError(f, "There already is a global function with name " + f.getName()
                        + " defined in " + old.getSourcePosition());
            }
        }

        // add global class declarations
        for (NQJClassDecl c : prog.getClassDecls()) {
            NQJClassDecl old = globalClasses.put(c.getName(), c);
            if (old != null) {
                analysis.addError(c, "There already is a global class with name " + c.getName()
                        + " defined in " + old.getSourcePosition());
            }
        }

        for (NQJInterfaceDecl i : prog.getInterfaceDecls()) {
            String interfaceName = i.getName();
            // check if a class with the same name exists. Resolved in favor of classes
            NQJClassDecl c = globalClasses.get(interfaceName);
            if (!(c == null)) {
                analysis.addError(c,
                        "You can not declare an interface and a class with the same name "
                        + interfaceName
                        + ". Resolved in favor of the class defined in " + c.getSourcePosition());
            } else {
                NQJInterfaceDecl old = globalInterfaces.put(interfaceName, i);
                if (old != null) {
                    analysis.addError(i, "There already is an interface with name " + i.getName()
                            + " defined in " + old.getSourcePosition());
                }
            }
        }

        createInternalInterfaceAndClassTypes(globalInterfaces, globalClasses);
    }

    private void createInternalInterfaceAndClassTypes(
            Map<String, NQJInterfaceDecl> globalInterfaces,
            Map<String, NQJClassDecl> globalClasses) {
        createInternalInterfaceTypes(globalInterfaces);
        createInternalClassTypes(globalClasses);
    }

    private void createInternalClassTypes(Map<String, NQJClassDecl> globalClasses) {
        // fill classTypes
        for (String className : globalClasses.keySet()) {
            getClassTypeInternal(className, new ArrayList<>());
        }
    }

    private void createInternalInterfaceTypes(Map<String, NQJInterfaceDecl> globalInterfaces) {
        // fill interfaceTypes
        for (String interfaceName : globalInterfaces.keySet()) {
            getInterfaceTypeInternal(interfaceName);
        }
    }

    /**
     * A look-up function to retrieve a global function declaration, given its name.
     *
     * @param functionName the name of the global function declaration that is to be returned
     * @return the function declaration of the global function with name functionName
     */
    public NQJFunctionDecl lookupFunction(String functionName) {
        return globalFunctions.get(functionName);
    }

    /**
     * A look-up function to retrieve a global class declaration, given its name.
     *
     * @param className the name of the global class declaration that is to be returned
     * @return the class declaration of the global class with name className
     */
    public NQJClassDecl lookupClass(String className) {
        return globalClasses.get(className);
    }

    /**
     * A look-up function to retrieve a global interface declaration, given its name.
     *
     * @param interfaceName the name of the interface to be retrieved
     * @return the interface declaration
     */
    public NQJInterfaceDecl lookupInterface(String interfaceName) {
        return globalInterfaces.get(interfaceName);
    }

    /**
     * Transform base type to array type.
     */
    public ArrayType getArrayType(Type baseType) {
        if (!arrayTypes.containsKey(baseType)) {
            arrayTypes.put(baseType, new ArrayType(baseType));
        }
        return arrayTypes.get(baseType);
    }


    /**
     * Get interface type by name.
     *
     * @param interfaceName the name of the interface
     * @return the interface if found, Type.Any if not
     */
    public Type getInterfaceType(String interfaceName) {
        InterfaceType res = (InterfaceType) getInterfaceTypeInternal(interfaceName);
        if (res == null) {
            return Type.ANY;
        }
        return res;
    }

    private Type getInterfaceTypeInternal(String interfaceName) {
        NQJInterfaceDecl decl = lookupInterface(interfaceName);
        if (decl == null) {
            return null;
        } else {
            // return cached interfaceType object or create it and add to cache
            InterfaceType i = interfaceTypes.get(interfaceName);
            if (i != null) {
                return i;
            } else {
                return createAndAddInterfaceType(decl);
            }
        }
    }

    private InterfaceType createAndAddInterfaceType(NQJInterfaceDecl interfaceDecl) {
        Map<String, NQJFunctionDecl> functions = new HashMap<>();

        NQJFunctionDeclList fs = interfaceDecl.getMethods();
        for (NQJFunctionDecl f : fs) {
            NQJFunctionDecl old = functions.put(f.getName(), f);
            if (old != null) {
                analysis.addError(interfaceDecl,
                        "There already is a function with name " + old.getName()
                                + " for interface " + interfaceDecl.getName() + " "
                                + " defined in " + old.getSourcePosition()
                );
            }
        }
        InterfaceType interfaceType = new InterfaceType(
                interfaceDecl.getName(), functions);
        interfaceTypes.put(interfaceType.getName(), interfaceType);
        return interfaceType;
    }

    /**
     * Returns the ClassType object with the parameter name.
     *
     * @param className the name of the ClassType object that is to be retrieved
     * @return Type.ANY if the classType has not been declared
     *      or the ClassType object with name "className"
     */
    public Type getClassType(String className) {
        ClassType res = (ClassType) getClassTypeInternal(className, new ArrayList<>());
        if (res == null) {
            return Type.ANY;
        }
        return res;
    }

    private Type getClassTypeInternal(String className, List<NQJClassDecl> inheritanceTrace) {
        NQJClassDecl decl = lookupClass(className);
        if (decl == null) {
            return null;
        } else {
            // return cached classType object or create it and add to cache
            ClassType c = classTypes.get(className);
            if (c != null) {
                return c;
            } else {
                return createAndAddClassType(decl, inheritanceTrace);
            }
        }
    }

    private ClassType createAndAddClassType(
            NQJClassDecl classDecl, List<NQJClassDecl> inheritanceTrace) {
        // check for inheritance cycle
        if (inheritanceTrace.contains(classDecl)) {
            analysis.addError(classDecl, "Inheritance cycle detected:  " + inheritanceTrace);
            return null;
        } else {
            inheritanceTrace.add(classDecl);
        }

        String className = classDecl.getName();

        ClassType parent = null;
        List<InterfaceType> implementsInterfaces = new ArrayList<>();
        HashMap<String, NQJVarDecl> fields = new HashMap<>();
        HashMap<String, NQJFunctionDecl> functions = new HashMap<>();

        boolean hasSuperclass = classDecl.getExtended() instanceof NQJExtendsClass;

        if (hasSuperclass) {
            NQJExtendsClass extended = (NQJExtendsClass) classDecl.getExtended();
            // fill super-class recursively
            parent = (ClassType) getClassTypeInternal(extended.getName(), inheritanceTrace);
            if (parent == null) {
                analysis.addError(classDecl,
                        "Undefined superclass " + extended.getName()
                                + " for class " + className
                );
            } else {
                // fill fields and functions with inherited ones
                classDecl.setDirectSuperClass(this.globalClasses.get(parent.getName()));
                fields.putAll(parent.getFields());
                functions.putAll(parent.getMethods());
            }
        }

        NQJVarDeclList localFields = classDecl.getFields();
        HashMap<String, NQJVarDecl> nonInheritedFields = new HashMap<>();
        for (int i = 0; i < localFields.size(); i++) {
            NQJVarDecl localField = localFields.get(i);
            NQJVarDecl old = nonInheritedFields.put(localField.getName(), localField);
            if (old != null) {
                analysis.addError(classDecl,
                        "Class " + className
                                + " already contains a field with name "
                                + localField.getName()
                );
            }
        }
        fields.putAll(nonInheritedFields);

        NQJFunctionDeclList localFunctions = classDecl.getMethods();
        // use separate list to check for duplicate method names
        HashMap<String, NQJFunctionDecl> nonInheritedMethods = new HashMap<>();
        for (int i = 0; i < localFunctions.size(); i++) {
            NQJFunctionDecl localFunc = localFunctions.get(i);
            String methodName = localFunc.getName();
            NQJFunctionDecl old = nonInheritedMethods.put(methodName, localFunc);
            if (old != null) {
                analysis.addError(classDecl,
                        "Class " + className
                                + " already contains a method with name " + methodName
                );
            }
        }

        functions.putAll(nonInheritedMethods); // class overriding

        boolean isImplementingInterfaces = (classDecl.getImpl() instanceof NQJImplementsInterfaces);
        if (isImplementingInterfaces) {
            NQJImplementsInterfaces implemented
                    = (NQJImplementsInterfaces) classDecl.getImpl();
            ArrayList<String> interfaceNameList = implemented.getInterfaces();
            for (String interfaceName : interfaceNameList) {
                InterfaceType implementsInterface =
                        (InterfaceType) getInterfaceTypeInternal(interfaceName);

                if (implementsInterface == null) {
                    analysis.addError(classDecl,
                            "Undefined interface " + interfaceNameList.get(0)
                                    + " for class " + classDecl.getName()
                    );
                } else {
                    // check if class implements all functions of its interface
                    Map<String, NQJFunctionDecl> interfaceFunctions
                            = implementsInterface.getFunctions();
                    for (String interfaceFuncName : interfaceFunctions.keySet()) {
                        if (!functions.containsKey(interfaceFuncName)) {
                            // class does not implement function in interface
                            analysis.addError(classDecl,
                                    "Function " + interfaceFuncName
                                            + " of interface " + implementsInterface.getName()
                                            + " is missing in " + classDecl.getName()
                            );
                        }
                    }
                    implementsInterfaces.add(implementsInterface);
                }
            }
        }

        ClassType res = new ClassType(
                classDecl.getName(),
                parent,
                implementsInterfaces,
                fields,
                functions
        );
        classTypes.put(classDecl.getName(), res);

        return res;
    }

    /**
     * Returns the interface or class that corresponds to the parameter name.
     *
     * @param name the name of the interface or class
     * @return the interface or class Type object
     */
    public Type getInterfaceOrClassType(String name) {
        Type t = getClassType(name);
        if (!(t instanceof ClassType)) {
            t = getInterfaceType(name);
        }
        return t;
    }
}
