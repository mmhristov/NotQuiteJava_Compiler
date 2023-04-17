//generated by abstract-syntax-gen
package notquitejava.ast;
import java.util.*;

@SuppressWarnings({"cast", "unused", "rawtypes"})
class NQJExtendsClassImpl implements NQJExtendsClass{
    NQJExtendsClassImpl(String name) {
        if (name == null)
            throw new IllegalArgumentException("Element name must not be null.");
        this.name = name;
    }

    private NQJElement parent;
    public NQJElement getParent() { return parent; }
    public void setParent(NQJElement parent) {
        if (parent != null && this.parent != null) {
            throw new Error("Cannot change parent of element " + this.getClass().getSimpleName() + ", as it is already used in another tree."
                + "Use the copy method to create a new tree or remove the tree from its old parent or set the parent to null before moving the tree. ");
        }
        this.parent = parent;
    }

    public void replaceBy(NQJElement other) {
        if (parent == null)
            throw new RuntimeException("Node not attached to tree.");
        for (int i=0; i<parent.size(); i++) {
            if (parent.get(i) == this) {
                parent.set(i, other);
                return;
            }
        }
    }

    private String name;
    public void setName(String name) {
        if (name == null) throw new IllegalArgumentException();
        this.name = name;
    } 
    public String getName() { return name; }

    public NQJElement get(int i) {
        switch (i) {
            default: throw new IllegalArgumentException("Index out of range: " + i);
        }
    }
    public NQJElement set(int i, NQJElement newElem) {
        NQJElement oldElem;
        switch (i) {
            default: throw new IllegalArgumentException("Index out of range: " + i);
        }
    }

    @Override
    public void forEachElement(java.util.function.Consumer<? super NQJElement> action) {
    }
    public int size() {
        return 0;
    }
    @Override public NQJExtendsClass copy() {
        NQJExtendsClass result = new NQJExtendsClassImpl(name);
result.setSourcePosition(getSourcePosition());
        return result;
    }

    @Override public NQJExtendsClass copyWithRefs() {
        NQJExtendsClass res = copy();
        return res;
    }

    @Override public void clearAttributes() {
        clearAttributesLocal();
    }
    @Override public void clearAttributesLocal() {
    }
    @Override public void accept(Visitor v) {
        v.visit(this);
    }
    @Override public <T> T match(NQJElement.Matcher<T> matcher) {
        return matcher.case_ExtendsClass(this);
    }
    @Override public void match(NQJElement.MatcherVoid matcher) {
        matcher.case_ExtendsClass(this);
    }

    @Override public <T> T match(NQJExtended.Matcher<T> matcher) {
        return matcher.case_ExtendsClass(this);
    }
    @Override public void match(NQJExtended.MatcherVoid matcher) {
        matcher.case_ExtendsClass(this);
    }

    @Override public String toString() {
        return "ExtendsClass(" + name+")";
    }
    public boolean structuralEquals(NQJElement e) {
        if (e instanceof NQJExtendsClass) {
            NQJExtendsClass o = (NQJExtendsClass) e;
            return java.util.Objects.equals(name, o.getName());
        } else {
            return false;
        }
    }
    private frontend.SourcePosition sourcePosition;
    /** "information about the source code"*/
    public frontend.SourcePosition getSourcePosition() {
        return sourcePosition;
    }
    /** "information about the source code"*/
    public void setSourcePosition(frontend.SourcePosition sourcePosition) {
        this.sourcePosition = sourcePosition;
    }
}
