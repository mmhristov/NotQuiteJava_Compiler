//generated by abstract-syntax-gen
package notquitejava.ast;
import java.util.*;

public interface NQJTopLevelDecl extends NQJElement{
    void setName(String name);
    String getName();
    NQJElement getParent();
    <T> T match(Matcher<T> s);
    void match(MatcherVoid s);
    public interface Matcher<T> {
        T case_InterfaceDecl(NQJInterfaceDecl interfaceDecl);
        T case_ClassDecl(NQJClassDecl classDecl);
        T case_FunctionDecl(NQJFunctionDecl functionDecl);
    }

    public interface MatcherVoid {
        void case_InterfaceDecl(NQJInterfaceDecl interfaceDecl);
        void case_ClassDecl(NQJClassDecl classDecl);
        void case_FunctionDecl(NQJFunctionDecl functionDecl);
    }

    NQJTopLevelDecl copy();
    NQJTopLevelDecl copyWithRefs();
    /** "information about the source code"*/
    public abstract frontend.SourcePosition getSourcePosition();
    /** "information about the source code"*/
    public abstract void setSourcePosition(frontend.SourcePosition sourcePosition);
}
