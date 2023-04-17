package frontend;

import java.io.File;
import java.io.FileReader;
import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.Symbol;
import notquitejava.ast.NQJElement;
import notquitejava.ast.NQJProgram;
import notquitejava.syntax.Lexer;
import notquitejava.syntax.NotQuiteJavaParser;


/**
 * Frontend for parsing a NotQuiteJava file.
 */
public class NQJFrontend {

    /**
     * A list of syntax errors collected while parsing.
     */
    private final List<SyntaxError> syntaxErrors = new ArrayList<>();

    /**
     * Parses a NotQuiteJava program from a Reader.
     */
    public NQJProgram parse(Reader in) throws Exception {
        ComplexSymbolFactory sf = new NQJSymbolFactory();
        Lexer lexer = new Lexer(sf, in);
        NotQuiteJavaParser parser = new NotQuiteJavaParser(lexer, sf);

        parser.onError(syntaxErrors::add);

        Symbol result = parser.parse();
        if (result != null && result.value instanceof NQJProgram) {
            ((NQJProgram) result.value).accept(new StatementChecker(this));
            return (NQJProgram) result.value;
        }
        return null;
    }

    /**
     * Parses a NotQuiteJava program from a file.
     */
    public NQJProgram parseFile(File file) throws Exception {
        try (FileReader reader = new FileReader(file)) {
            return parse(reader);
        }
    }

    /**
     * Parses a NotQuiteJava program from the given input string.
     */
    public NQJProgram parseString(String input) throws Exception {
        return parse(new StringReader(input));
    }


    /**
     * Get the syntax errors produced while parsing.
     */
    public List<SyntaxError> getSyntaxErrors() {
        return syntaxErrors;
    }

    /**
     * A symbol factory, which sets the source position of NQJElements created by the parser.
     */
    static class NQJSymbolFactory extends ComplexSymbolFactory {

        @Override
        public Symbol newSymbol(String name, int id, Location left, Location right, Object value) {
            if (value instanceof NQJElement) {
                NQJElement e = (NQJElement) value;
                e.setSourcePosition(new SourcePosition(left.getUnit(),
                        left.getLine(), left.getColumn(),
                        right.getLine(), right.getColumn()));
            }
            return super.newSymbol(name, id, left, right, value);
        }

        @Override
        public Symbol newSymbol(String name, int id, Symbol l, Symbol r, Object value) {
            if (value instanceof NQJElement) {
                NQJElement e = (NQJElement) value;
                ComplexSymbol leftS = (ComplexSymbol) l;
                ComplexSymbol rightS = (ComplexSymbol) r;
                Location left = leftS.getLeft();
                Location right = rightS.getRight();
                e.setSourcePosition(new SourcePosition(left.getUnit(),
                        left.getLine(), left.getColumn(),
                        right.getLine(), right.getColumn()));
            }
            return super.newSymbol(name, id, l, r, value);
        }

        @Override
        public Symbol newSymbol(String name, int id, Symbol l, Object value) {
            if (value instanceof NQJElement) {
                NQJElement e = (NQJElement) value;
                ComplexSymbol leftS = (ComplexSymbol) l;
                Location left = leftS.getLeft();
                Location right = leftS.getRight();
                e.setSourcePosition(new SourcePosition(left.getUnit(),
                        left.getLine(), left.getColumn(),
                        right.getLine(), right.getColumn()));
            }
            return super.newSymbol(name, id, l, value);
        }

    }
}
