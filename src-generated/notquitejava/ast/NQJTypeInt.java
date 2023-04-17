//generated by abstract-syntax-gen
package notquitejava.ast;
import java.util.*;

public interface NQJTypeInt extends NQJBaseType, NQJElement {
    NQJElement getParent();
    NQJTypeInt copy();
    NQJTypeInt copyWithRefs();
    void clearAttributes();
    void clearAttributesLocal();
    /** "information about the source code"*/
    public abstract frontend.SourcePosition getSourcePosition();
    /** "information about the source code"*/
    public abstract void setSourcePosition(frontend.SourcePosition sourcePosition);
    /** null*/
    public abstract analysis.Type getType();
    /** null*/
    public abstract void setType(analysis.Type type);
}
