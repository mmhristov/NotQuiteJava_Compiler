//generated by abstract-syntax-gen
package notquitejava.ast;
import java.util.*;

public interface NQJBoolConst extends NQJElement, NQJExpr {
    void setBoolValue(boolean boolValue);
    boolean getBoolValue();
    NQJElement getParent();
    NQJBoolConst copy();
    NQJBoolConst copyWithRefs();
    void clearAttributes();
    void clearAttributesLocal();
    /** "information about the source code"*/
    public abstract frontend.SourcePosition getSourcePosition();
    /** "information about the source code"*/
    public abstract void setSourcePosition(frontend.SourcePosition sourcePosition);
}
