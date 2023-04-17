package minillvm.printer;

import minillvm.ast.*;

import java.util.HashSet;
import java.util.Set;

/**
 * Duplicate name elimination.
 */
public class DuplicateNames {

    /**
     * Eliminates duplicate names in program.
     */
    public static void eliminateDuplicateNames(Prog prog) {
        Set<String> globalNames = new HashSet<>();

        for (TypeStruct s : prog.getStructTypes()) {
            eliminateDuplicateNames(s, globalNames);
        }
        for (Global g : prog.getGlobals()) {
            eliminateDuplicateNames(g, globalNames);
        }
        for (Proc p : prog.getProcedures()) {
            eliminateDuplicateNames(p, globalNames);
        }
        for (Proc proc : prog.getProcedures()) {
            eliminateDuplicateNames(globalNames, proc);
        }
    }

    /**
     * Eliminates duplicate names in a proc.
     */
    public static void eliminateDuplicateNames(Set<String> globalNames, Proc proc) {
        Set<String> localNames = new HashSet<>();
        for (Variable v : proc.getParameters()) {
            eliminateDuplicateNames(v, globalNames, localNames);
        }
        for (BasicBlock b : proc.getBasicBlocks()) {
            eliminateDuplicateNames(b, globalNames, localNames);

            for (Instruction instr : b) {
                if (instr instanceof Assign) {
                    Assign assign = (Assign) instr;
                    eliminateDuplicateNames(assign.getVar(), globalNames, localNames);
                }
            }
        }
    }

    /**
     * Eliminates duplicate names in a basic block.
     */
    private static void eliminateDuplicateNames(BasicBlock e, Set<String> globalNames,
                                                Set<String> localNames) {
        String name = e.getName();
        if (name == null) {
            name = "block";
        }
        int i = 1;
        while (globalNames.contains(name) || localNames.contains(name)) {
            name = e.getName() + i;
            i++;
        }
        e.setName(name);
        localNames.add(name);
    }

    /**
     * Eliminates duplicate names in an element.
     */
    private static void eliminateDuplicateNames(ElementWithName e, Set<String> globalNames,
                                                Set<String> localNames) {
        String name = e.getName();
        int i = 1;
        while (globalNames.contains(name) || localNames.contains(name)) {
            name = e.getName() + i;
            i++;
        }
        e.setName(name);
        localNames.add(name);
    }

    /**
     * Eliminates duplicate names in an element.
     */
    private static void eliminateDuplicateNames(ElementWithName e, Set<String> globalNames) {
        String name = e.getName();
        int i = 1;
        while (globalNames.contains(name)) {
            name = e.getName() + i;
            i++;
        }
        e.setName(name);
        globalNames.add(name);
    }
}
