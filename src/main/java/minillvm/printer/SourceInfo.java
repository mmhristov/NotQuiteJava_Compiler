package minillvm.printer;

import minillvm.ast.Element;

/**
 * Pojo for source positions, saving original NQJ position.
 */
public class SourceInfo {

    private String comment = null;
    private int notquitejavaLineNr = 0;

    public static SourceInfo get(Element e) {
        return new SourceInfo();
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getNotQuiteJavaLineNr() {
        return notquitejavaLineNr;
    }

    public void setNotQuiteJavaLineNr(int notquitejavaLineNr) {
        this.notquitejavaLineNr = notquitejavaLineNr;
    }

}
