package translation;

import minillvm.ast.*;
import notquitejava.ast.*;

import static minillvm.ast.Ast.*;

/**
 * Evaluate L values.
 */
public class ExprLValue implements NQJExprL.Matcher<Operand> {
    private final Translator tr;

    public ExprLValue(Translator translator) {
        this.tr = translator;
    }

    @Override
    public Operand case_ArrayLookup(NQJArrayLookup e) {
        Operand arrayAddr = tr.exprRvalue(e.getArrayExpr());
        tr.addNullcheck(arrayAddr, "Nullpointer exception in line " + tr.sourceLine(e));

        Operand index = tr.exprRvalue(e.getArrayIndex());

        Operand len = tr.getArrayLen(arrayAddr);
        TemporaryVar smallerZero = Ast.TemporaryVar("smallerZero");
        TemporaryVar lenMinusOne = Ast.TemporaryVar("lenMinusOne");
        TemporaryVar greaterEqualLen = Ast.TemporaryVar("greaterEqualLen");
        TemporaryVar outOfBoundsV = Ast.TemporaryVar("outOfBounds");
        final BasicBlock outOfBounds = tr.newBasicBlock("outOfBounds");
        final BasicBlock indexInRange = tr.newBasicBlock("indexInRange");


        // smallerZero = index < 0
        tr.addInstruction(BinaryOperation(smallerZero, index, Slt(), Ast.ConstInt(0)));
        // lenMinusOne = length - 1
        tr.addInstruction(BinaryOperation(lenMinusOne, len, Sub(), Ast.ConstInt(1)));
        // greaterEqualLen = lenMinusOne < index
        tr.addInstruction(BinaryOperation(greaterEqualLen,
                VarRef(lenMinusOne), Slt(), index.copy()));
        // outOfBoundsV = smallerZero || greaterEqualLen
        tr.addInstruction(BinaryOperation(outOfBoundsV,
                VarRef(smallerZero), Or(), VarRef(greaterEqualLen)));

        tr.getCurrentBlock().add(Ast.Branch(VarRef(outOfBoundsV), outOfBounds, indexInRange));

        tr.addBasicBlock(outOfBounds);
        outOfBounds.add(Ast.HaltWithError("Index out of bounds error in line " + tr.sourceLine(e)));

        tr.addBasicBlock(indexInRange);
        tr.setCurrentBlock(indexInRange);
        TemporaryVar indexAddr = Ast.TemporaryVar("indexAddr");
        tr.addInstruction(Ast.GetElementPtr(indexAddr, arrayAddr, Ast.OperandList(
                Ast.ConstInt(0),
                Ast.ConstInt(1),
                index.copy()
        )));
        return VarRef(indexAddr);
    }

    @Override
    public Operand case_FieldAccess(NQJFieldAccess e) {
        String fieldName = e.getFieldName();
        Operand receiver = tr.exprRvalue(e.getReceiver());
        tr.addNullcheck(receiver, "Nullpointer exception in line " + tr.sourceLine(e));

        return getFieldReference(receiver, fieldName);
    }

    private Operand getFieldReference(Operand receiver, String fieldName) {
        TypePointer pointer = (TypePointer) receiver.calculateType();
        TypeStruct classStruct =  (TypeStruct) pointer.getTo();

        // In case of inheritance it is necessary
        // to start the search from the bottom (i.e. non-inherited fields).
        // For future convenience, we will do this here too.
        int index = -1; // the position of the field in the struct.
        for (int i = classStruct.getFields().size() - 1; i > 0; i--) {
            StructField field = classStruct.getFields().get(i);
            if (field.getName().equals(fieldName)) {
                // field was found in class struct
                index = i;
                break;
            }
        }

        // note: analysis phase should guarantee here that the field exists.
        //  -> to be sure, possibly throw an exception for i = -1.

        final TemporaryVar ptrField = TemporaryVar("ptrField");

        tr.addInstruction(
                GetElementPtr(ptrField, receiver, OperandList(ConstInt(0), ConstInt(index)))
        );

        return VarRef(ptrField);
    }

    @Override
    public Operand case_VarUse(NQJVarUse e) {
        NQJVarDecl varDecl = e.getVariableDeclaration();
        String varName = varDecl.getName();
        // check in local variables first (field shadowing)
        TemporaryVar var = tr.getLocalVarLocation(varDecl);
        if (var == null) {
            // search in class fields if not found in local fields
            Parameter thisParam = tr.getThisParameter();
            return getFieldReference(VarRef(thisParam), varName);
        }
        // local TemporaryVar
        return VarRef(tr.getLocalVarLocation(varDecl));
    }

}
