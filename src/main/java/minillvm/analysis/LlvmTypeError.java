package minillvm.analysis;

import frontend.SourcePosition;

/**
 * Wrapper for llvm type errors that saves the position.
 */
public class LlvmTypeError extends RuntimeException {
    private final SourcePosition source;

    private static final long serialVersionUID = 1372383462499488764L;

    public LlvmTypeError(SourcePosition source, String message) {
        super(message);
        this.source = source;
    }

    public int getLine() {
        return source.getLine();
    }

    public int getColumn() {
        return source.getColumn();
    }

    @Override
    public String toString() {
        return "Error in line " + getLine() + ":" + getColumn() + ": " + getMessage();
    }
}
