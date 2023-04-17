//generated by abstract-syntax-gen
package notquitejava.ast;
import java.util.*;

public interface NQJBaseType extends NQJElement, NQJType{
    NQJElement getParent();
    <T> T match(Matcher<T> s);
    void match(MatcherVoid s);
    public interface Matcher<T> {
        T case_TypeInterfaceOrClass(NQJTypeInterfaceOrClass typeInterfaceOrClass);
        T case_TypeBool(NQJTypeBool typeBool);
        T case_TypeInt(NQJTypeInt typeInt);
    }

    public interface MatcherVoid {
        void case_TypeInterfaceOrClass(NQJTypeInterfaceOrClass typeInterfaceOrClass);
        void case_TypeBool(NQJTypeBool typeBool);
        void case_TypeInt(NQJTypeInt typeInt);
    }

    NQJBaseType copy();
    NQJBaseType copyWithRefs();
    /** "information about the source code"*/
    public abstract frontend.SourcePosition getSourcePosition();
    /** "information about the source code"*/
    public abstract void setSourcePosition(frontend.SourcePosition sourcePosition);
    /** null*/
    public abstract analysis.Type getType();
    /** null*/
    public abstract void setType(analysis.Type type);
}