//generated by abstract-syntax-gen
package notquitejava.ast;
import java.util.*;

public interface NQJNumber extends NQJElement, NQJExpr {
    void setIntValue(int intValue);
    int getIntValue();
    NQJElement getParent();
    NQJNumber copy();
    NQJNumber copyWithRefs();
    void clearAttributes();
    void clearAttributesLocal();
    /** "information about the source code"*/
    public abstract frontend.SourcePosition getSourcePosition();
    /** "information about the source code"*/
    public abstract void setSourcePosition(frontend.SourcePosition sourcePosition);
}
