//generated by abstract-syntax-gen
package notquitejava.ast;
import java.util.*;

public interface NQJExprThis extends NQJElement, NQJExpr {
    NQJElement getParent();
    NQJExprThis copy();
    NQJExprThis copyWithRefs();
    void clearAttributes();
    void clearAttributesLocal();
    /** "information about the source code"*/
    public abstract frontend.SourcePosition getSourcePosition();
    /** "information about the source code"*/
    public abstract void setSourcePosition(frontend.SourcePosition sourcePosition);
}
