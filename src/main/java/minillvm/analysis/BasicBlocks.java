package minillvm.analysis;

import minillvm.ast.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


/**
 * Basic block helper.
 */
public class BasicBlocks {

    /** Get all phi nodes of a basic block. */
    public static List<PhiNode> getPhiNodes(BasicBlock block) {
        List<PhiNode> result = new ArrayList<>();
        for (Instruction i : block) {
            if (i instanceof CommentInstr) {
                continue;
            }
            if (i instanceof PhiNode) {
                result.add((PhiNode) i);
            } else {
                return result;
            }
        }
        return result;
    }

    /** Get terminating instruction of a basic block, if any. */
    public static Optional<TerminatingInstruction> getTerminatingInstruction(BasicBlock block) {
        for (int i = block.size() - 1; i >= 0; i--) {
            Instruction instr = block.get(i);
            if (instr instanceof CommentInstr) {
                continue;
            }
            if (instr instanceof TerminatingInstruction) {
                return Optional.of((TerminatingInstruction) instr);
            }
            break;
        }
        return Optional.empty();
    }
}
