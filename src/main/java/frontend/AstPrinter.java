package frontend;

import notquitejava.ast.*;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * Pretty printer for generated AST classes.
 * If the .ast file is modified, the printed has to be modified, too.
 */
public class AstPrinter implements NQJElement.Visitor {
    private final StringBuilder out = new StringBuilder();
    private int indent = 0;

    /**
     * Printing a generic element.
     */
    public static String print(NQJElement ast) {
        if (ast == null) {
            return "<null>";
        }
        AstPrinter printer = new AstPrinter();
        ast.accept(printer);
        return printer.out.toString();
    }

    private void print(String s) {
        out.append(s);
    }

    private void println() {
        out.append("\n");
        out.append("    ".repeat(Math.max(0, indent)));
    }

    private void println(String s) {
        out.append(s);
        println();
    }

    @Override
    public void visit(NQJTopLevelDeclList classDeclList) {
        for (NQJTopLevelDecl c : classDeclList) {
            c.accept(this);
            println();
        }

    }

    @Override
    public void visit(NQJClassDeclList classDeclList) {
        for (NQJClassDecl c : classDeclList) {
            c.accept(this);
            println();
        }
    }

    @Override
    public void visit(NQJInterfaceDeclList interfaceDeclList) {
        for (NQJInterfaceDecl i : interfaceDeclList) {
            i.accept(this);
            println();
        }
    }

    @Override
    public void visit(NQJNewArray na) {
        print("(new ");
        na.getBaseType().accept(this);
        print("[");
        na.getArraySize().accept(this);
        print("])");
    }

    @Override
    public void visit(NQJExprNull exprNull) {
        print("null");
    }

    @Override
    public void visit(NQJStmtAssign stmtAssign) {
        stmtAssign.getAddress().accept(this);
        print(" = ");
        stmtAssign.getValue().accept(this);
        println(";");
    }

    @Override
    public void visit(NQJLess less) {
        print("<");
    }

    @Override
    public void visit(NQJVarDeclList varDeclList) {
        for (NQJVarDecl v : varDeclList) {
            v.accept(this);
            println(";");
        }
    }

    @Override
    public void visit(NQJExtendsNothing extendsNothing) {

    }

    @Override
    public void visit(NQJVarUse varUse) {
        print(varUse.getVarName());
    }

    @Override
    public void visit(NQJRead read) {
        read.getAddress().accept(this);
    }

    @Override
    public void visit(NQJExprList exprList) {
        for (NQJExpr expr : exprList) {
            if (expr != exprList.get(0)) {
                print(", ");
            }
            expr.accept(this);
        }

    }

    @Override
    public void visit(NQJNegate negate) {
        print("!");
    }

    @Override
    public void visit(NQJStmtWhile stmtWhile) {
        print("while (");
        stmtWhile.getCondition().accept(this);
        print(") ");
        stmtWhile.getLoopBody().accept(this);
    }

    @Override
    public void visit(NQJExtendsClass extendsClass) {
        print("extends ");
        print(extendsClass.getName());
        print(" ");
    }

    @Override
    public void visit(NQJImplementsNothing implementsNothing) {
        // nothing
    }

    @Override
    public void visit(NQJImplementsInterfaces implementsInterfaces) {
        print("implements ");
        ArrayList<String> interfaces = implementsInterfaces.getInterfaces();
        Iterator<String> i = interfaces.iterator();
        for (;;) {
            print(i.next());
            if (!i.hasNext()) {
                break;
            }
            print(", ");
        }
        print(" ");
    }

    @Override
    public void visit(NQJArrayLookup arrayLookup) {
        arrayLookup.getArrayExpr().accept(this);
        print("[");
        arrayLookup.getArrayIndex().accept(this);
        print("]");
    }

    @Override
    public void visit(NQJMethodCall methodCall) {
        methodCall.getReceiver().accept(this);
        print(".");
        print(methodCall.getMethodName());
        print("(");
        methodCall.getArguments().accept(this);
        print(")");
    }

    @Override
    public void visit(NQJFunctionCall functionCall) {
        print(functionCall.getMethodName());
        print("(");
        functionCall.getArguments().accept(this);
        print(")");
    }

    @Override
    public void visit(NQJNewObject newObject) {
        print("new ");
        print(newObject.getClassName());
        print("()");
    }

    @Override
    public void visit(NQJTimes times) {
        print("*");
    }

    @Override
    public void visit(NQJMinus minus) {
        print("-");
    }

    @Override
    public void visit(NQJExprUnary exprUnary) {
        print("(");
        exprUnary.getUnaryOperator().accept(this);
        print(" ");
        exprUnary.getExpr().accept(this);
        print(")");
    }

    @Override
    public void visit(NQJStmtReturn stmtReturn) {
        print("return ");
        stmtReturn.getResult().accept(this);
        println(";");
    }

    @Override
    public void visit(NQJProgram program) {
        program.getFunctionDecls().accept(this);
        program.getClassDecls().accept(this);
    }

    @Override
    public void visit(NQJEquals equals) {
        print("==");
    }

    @Override
    public void visit(NQJUnaryMinus unaryMinus) {
        print("-");
    }

    @Override
    public void visit(NQJExprThis exprThis) {
        print("this");
    }

    @Override
    public void visit(NQJVarDecl varDecl) {
        varDecl.getType().accept(this);
        print(" ");
        print(varDecl.getName());
    }

    @Override
    public void visit(NQJFieldAccess fieldAccess) {
        fieldAccess.getReceiver().accept(this);
        print(".");
        print(fieldAccess.getFieldName());
    }

    @Override
    public void visit(NQJNumber number) {
        print("" + number.getIntValue());
    }

    @Override
    public void visit(NQJTypeInt typeInt) {
        print("int");
    }

    @Override
    public void visit(NQJFunctionDeclList methodDeclList) {
        for (NQJFunctionDecl m : methodDeclList) {
            m.accept(this);
            println();
        }
    }

    @Override
    public void visit(NQJArrayLength arrayLength) {
        arrayLength.getArrayExpr().accept(this);
        print(".length");
    }

    @Override
    public void visit(NQJPlus plus) {
        print("+");
    }

    @Override
    public void visit(NQJExprBinary exprBinary) {
        print("(");
        exprBinary.getLeft().accept(this);
        print(" ");
        exprBinary.getOperator().accept(this);
        print(" ");
        exprBinary.getRight().accept(this);
        print(")");
    }

    @Override
    public void visit(NQJBlock block) {
        indent++;
        println("{");
        for (NQJStatement s : block) {
            s.accept(this);
            if (s instanceof NQJVarDecl) {
                println(";");
            }
        }
        indent--;
        println();
        println("}");

    }

    @Override
    public void visit(NQJDiv div) {
        print("/");
    }

    @Override
    public void visit(NQJBoolConst boolConst) {
        print("" + boolConst.getBoolValue());
    }

    @Override
    public void visit(NQJStmtIf stmtIf) {
        print("if (");
        stmtIf.getCondition().accept(this);
        print(") ");
        stmtIf.getIfTrue().accept(this);
        print("else ");
        stmtIf.getIfFalse().accept(this);

    }

    @Override
    public void visit(NQJTypeBool typeBool) {
        print("boolean");
    }

    @Override
    public void visit(NQJTypeInterfaceOrClass typeInterfaceOrClass) {
        print(typeInterfaceOrClass.getName());
    }

    @Override
    public void visit(NQJAnd and) {
        print("&&");
    }

    @Override
    public void visit(NQJStmtExpr stmtExpr) {
        stmtExpr.getExpr().accept(this);
        println(";");
    }

    @Override
    public void visit(NQJFunctionDecl methodDecl) {
        methodDecl.getReturnType().accept(this);
        print(" ");
        print(methodDecl.getName());
        print("(");
        for (NQJVarDecl p : methodDecl.getFormalParameters()) {
            if (p != methodDecl.getFormalParameters().get(0)) {
                print(", ");
            }
            p.accept(this);
        }
        print(") ");
        methodDecl.getMethodBody().accept(this);
    }

    @Override
    public void visit(NQJTypeArray typeArray) {
        typeArray.getComponentType().accept(this);
        print("[]");
    }

    @Override
    public void visit(NQJClassDecl classDecl) {
        print("class ");
        print(classDecl.getName());
        print(" ");
        classDecl.getExtended().accept(this);
        indent++;
        println(" {");
        for (NQJVarDecl v : classDecl.getFields()) {
            v.accept(this);
            println(";");
        }
        classDecl.getMethods().accept(this);
        indent--;
        println("}");

    }

    @Override
    public void visit(NQJInterfaceDecl interfaceDecl) {
        print("interface");
        print(interfaceDecl.getName());
        print(" ");
        indent++;
        println(" {");
        interfaceDecl.getMethods().accept(this);
        indent--;
        println("}");

    }

    @Override
    public void visit(NQJMemberDeclList memberDeclList) {
        for (NQJMemberDecl memberDecl : memberDeclList) {
            memberDecl.accept(this);
            println();
        }
    }
}