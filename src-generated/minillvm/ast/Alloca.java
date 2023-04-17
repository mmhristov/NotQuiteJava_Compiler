//generated by abstract-syntax-gen
package minillvm.ast;
import java.util.*;

public interface Alloca extends Assign, Element {
    void setVar(TemporaryVar var);
    TemporaryVar getVar();
    void setType(Type type);
    Type getType();
    Element getParent();
    Alloca copy();
    Alloca copyWithRefs();
    void clearAttributes();
    void clearAttributesLocal();
    /** */
    public abstract String toString();
}
