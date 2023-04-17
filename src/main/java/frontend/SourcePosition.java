package frontend;

/**
 * Pojo for source positions.
 */
public class SourcePosition {
    private final String unit;
    private final int line;
    private final int column;
    private final int endLine;
    private final int endColumn;

    /**
     * Constructor for converting line and column.
     */
    public SourcePosition(String unit, int line, int column, int endLine, int endColumn) {
        this.unit = unit;
        this.line = line;
        this.column = column;
        this.endLine = endLine;
        this.endColumn = endColumn;
    }

    public String getUnit() {
        return unit;
    }

    public int getLine() {
        return line;
    }

    public int getColumn() {
        return column;
    }

    public int getEndLine() {
        return endLine;
    }

    public int getEndColumn() {
        return endColumn;
    }
}
