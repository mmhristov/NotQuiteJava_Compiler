package frontend;

import notquitejava.ast.*;

/** Statement checker. **/
public class StatementChecker extends NQJElement.DefaultVisitor {


    private NQJFrontend frontend;

    public StatementChecker(NQJFrontend mjFrontend) {
        this.frontend = mjFrontend;
    }

    @Override
    public void visit(NQJStmtExpr s) {
        super.visit(s);
        NQJExpr e = s.getExpr();
        if (!(e instanceof NQJMethodCall
                || e instanceof NQJNewObject
                || e instanceof NQJFunctionCall)
        ) {
            frontend.getSyntaxErrors().add(
                    new SyntaxError(e, "The expression " + e + " cannot appear as a statement.")
            );
        }
    }
}