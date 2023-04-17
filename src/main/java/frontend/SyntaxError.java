package frontend;

import notquitejava.ast.NQJElement;

/**
 * Wrapper for syntax errors that saves the position.
 */
public class SyntaxError extends RuntimeException {
    private SourcePosition source;

    private static final long serialVersionUID = -4009191552756622955L;

    public SyntaxError(String message, int line, int column) {
        super(message);
        this.source = new SourcePosition("", line, column, line, column);
    }

    /**
     * Syntax error constructor for an AST class.
     *
     * @param element AST element
     * @param message Error message
     */
    public SyntaxError(NQJElement element, String message) {
        super(message);
        while (element != null) {
            this.source = element.getSourcePosition();
            if (this.source != null) {
                break;
            }
            element = element.getParent();
        }
    }

    public int getLine() {
        return source.getLine();
    }

    public int getColumn() {
        return source.getColumn();
    }

    @Override
    public String toString() {
        return "Syntax error in line " + getLine() + ":" + getColumn() + ": " + getMessage();
    }

    public SourcePosition getSource() {
        return source;
    }
}