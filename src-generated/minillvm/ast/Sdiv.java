//generated by abstract-syntax-gen
package minillvm.ast;
import java.util.*;

public interface Sdiv extends Operator, Element {
    Element getParent();
    Sdiv copy();
    Sdiv copyWithRefs();
    void clearAttributes();
    void clearAttributesLocal();
    /** */
    public abstract String toString();
}