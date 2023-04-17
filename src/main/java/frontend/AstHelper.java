package frontend;

import java.util.ArrayList;
import java.util.List;
import notquitejava.ast.*;


/**
 * Helper methods to be used inside CUP grammar rules.
 */
public class AstHelper {
    /**
     * Parsing members, superinterfaces and superclasses of classes into a class declaration.
     */
    public static NQJClassDecl classDecl(
            String name, String ext,
            ArrayList<String> interfaces,
            List<NQJMemberDecl> members) {
        NQJFunctionDeclList methods = NQJ.FunctionDeclList();
        NQJVarDeclList fields = NQJ.VarDeclList();

        NQJExtended extended;
        if (ext == null) {
            extended = NQJ.ExtendsNothing();
        } else {
            extended = NQJ.ExtendsClass(ext);
        }

        NQJImplemented implemented;
        if (interfaces == null) {
            implemented = NQJ.ImplementsNothing();
        } else {
            implemented = NQJ.ImplementsInterfaces(interfaces);
        }

        for (NQJMemberDecl member : members) {
            member.match(new NQJMemberDecl.MatcherVoid() {

                @Override
                public void case_FunctionDecl(NQJFunctionDecl methodDecl) {
                    methods.add(methodDecl.copy());
                }

                @Override
                public void case_VarDecl(NQJVarDecl varDecl) {
                    fields.add(varDecl.copy());
                }
            });
        }

        return NQJ.ClassDecl(name, extended, implemented, fields, methods);
    }

    /** Parse members of interfaces into an interface declaration. */
    public static NQJInterfaceDecl interfaceDecl(String name, List<NQJFunctionDecl> members) {
        NQJFunctionDeclList methods = NQJ.FunctionDeclList();

        for (NQJFunctionDecl member : members) {
            methods.add(member.copy());
        }

        return NQJ.InterfaceDecl(name, methods);
    }

    /** Parsing top level delcaration into a program. */
    public static NQJProgram program(List<NQJTopLevelDecl> decls) {
        NQJFunctionDeclList functions = NQJ.FunctionDeclList();
        NQJClassDeclList classDecls = NQJ.ClassDeclList();
        NQJInterfaceDeclList interfaceDecls = NQJ.InterfaceDeclList();

        for (NQJTopLevelDecl decl : decls) {
            decl.match(new NQJTopLevelDecl.MatcherVoid() {
                @Override
                public void case_FunctionDecl(NQJFunctionDecl functionDecl) {
                    functions.add(functionDecl.copy());
                }

                @Override
                public void case_InterfaceDecl(NQJInterfaceDecl interfaceDecl) {
                    interfaceDecls.add(interfaceDecl.copy());
                }

                @Override
                public void case_ClassDecl(NQJClassDecl classDecl) {
                    classDecls.add(classDecl.copy());
                }
            });
        }

        return NQJ.Program(classDecls, functions, interfaceDecls);
    }

    /**
     * Create an array type out of a type and dimensions.
     */
    public static NQJType buildArrayType(NQJType t, int dimensions) {
        for (int i = 0; i < dimensions; i++) {
            t = NQJ.TypeArray(t, NQJ.Number(0));
        }
        return t;
    }

    /**
     * Create an array type out of a L expression and dimensions.
     */
    public static NQJType buildArrayType(NQJExprL e, int dimensions) {
        NQJType t;
        if (e instanceof NQJVarUse) {
            NQJVarUse vu = (NQJVarUse) e;
            t = NQJ.TypeInterfaceOrClass(vu.getVarName());
        } else {
            t = NQJ.TypeInterfaceOrClass("unknown type");
        }
        for (int i = 0; i < dimensions; i++) {
            t = NQJ.TypeArray(t, NQJ.Number(0));
        }
        return t;
    }

    /**
     * Creates an array out of the type, the size expression, and the dimensions.
     */
    public static NQJExpr newArray(NQJType t, NQJExprList sizes, int dimensions) {
        for (int i = 0; i < dimensions; i++) {
            t = NQJ.TypeArray(t, NQJ.Number(0));
        }

        for (int i = sizes.size() - 1; i > 0; i--) {
            t = NQJ.TypeArray(t, sizes.get(i).copy());
        }
        return NQJ.NewArray(t, sizes.get(0).copy());
    }
}