package translation;

import minillvm.ast.Ast;
import minillvm.ast.BasicBlock;
import minillvm.ast.Operand;
import minillvm.ast.TypePointer;
import notquitejava.ast.*;

/**
 * Statement Translator.
 */
public class StmtTranslator implements NQJStatement.MatcherVoid {

    private final Translator tr;

    public StmtTranslator(Translator translator) {
        this.tr = translator;
    }

    @Override
    public void case_VarDecl(NQJVarDecl s) {
        // no code, space is allocated at beginning of method
    }

    @Override
    public void case_StmtWhile(NQJStmtWhile s) {
        final BasicBlock whileStart = tr.newBasicBlock("whileStart");
        final BasicBlock loopBodyStart = tr.newBasicBlock("loopBodyStart");
        final BasicBlock endloop = tr.newBasicBlock("endloop");

        // goto loop start
        tr.getCurrentBlock().add(Ast.Jump(whileStart));

        tr.addBasicBlock(whileStart);
        tr.setCurrentBlock(whileStart);
        // evaluate condition
        Operand condition = tr.exprRvalue(s.getCondition());
        // branch based on condition
        tr.getCurrentBlock().add(Ast.Branch(condition, loopBodyStart, endloop));

        // translate loop body
        tr.addBasicBlock(loopBodyStart);
        tr.setCurrentBlock(loopBodyStart);
        tr.translateStmt(s.getLoopBody());
        // at end of loop body go to loop start
        tr.getCurrentBlock().add(Ast.Jump(whileStart));

        // continue after loop:
        tr.addBasicBlock(endloop);
        tr.setCurrentBlock(endloop);

    }

    @Override
    public void case_StmtExpr(NQJStmtExpr s) {
        // just translate the expression
        tr.exprRvalue(s.getExpr());
    }

    @Override
    public void case_StmtAssign(NQJStmtAssign s) {
        // first translate the left hand side
        final Operand lAddr = tr.exprLvalue(s.getAddress());

        // then translate the right hand side
        final Operand rValue = tr.exprRvalue(s.getValue());

        final Operand rValueCasted = tr.addCastIfNecessary(rValue,
                ((TypePointer) lAddr.calculateType()).getTo());

        // finally store the result
        tr.addInstruction(Ast.Store(lAddr, rValueCasted));
    }

    @Override
    public void case_StmtIf(NQJStmtIf s) {
        final BasicBlock ifTrue = tr.newBasicBlock("ifTrue");
        final BasicBlock ifFalse = tr.newBasicBlock("ifFalse");
        final BasicBlock endif = tr.newBasicBlock("endif");

        // translate the condition
        Operand condition = tr.exprRvalue(s.getCondition());
        // jump based on condition
        tr.getCurrentBlock().add(Ast.Branch(condition, ifTrue, ifFalse));

        // translate ifTrue
        tr.addBasicBlock(ifTrue);
        tr.setCurrentBlock(ifTrue);
        tr.translateStmt(s.getIfTrue());
        tr.getCurrentBlock().add(Ast.Jump(endif));

        // translate ifFalse
        tr.addBasicBlock(ifFalse);
        tr.setCurrentBlock(ifFalse);
        tr.translateStmt(s.getIfFalse());
        tr.getCurrentBlock().add(Ast.Jump(endif));

        // continue at endif
        tr.addBasicBlock(endif);
        tr.setCurrentBlock(endif);
    }

    @Override
    public void case_Block(NQJBlock block) {
        for (NQJStatement s : block) {
            tr.translateStmt(s);
        }
    }

    @Override
    public void case_StmtReturn(NQJStmtReturn s) {
        Operand result = tr.exprRvalue(s.getResult());

        Operand castedResult = tr.addCastIfNecessary(result, tr.getCurrentReturnType());

        tr.getCurrentBlock().add(Ast.ReturnExpr(castedResult));

        // set to dummy block, so that nothing is overwritten
        tr.setCurrentBlock(tr.unreachableBlock());
    }
}
