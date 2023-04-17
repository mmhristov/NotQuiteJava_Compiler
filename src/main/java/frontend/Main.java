package frontend;

import java.io.FileReader;
import java.io.StringReader;
import java.util.Scanner;
import notquitejava.ast.NQJProgram;

/**
 * Entry-point for parsing NQJ files.
 */
public class Main {
    /**
     * Entry main function.
     */
    public static void main(String[] args) throws Exception {
        String fileName;
        if (args.length > 0) {
            fileName = args[0];
        } else {
            System.out.println("Enter a filename: ");
            fileName = new Scanner(System.in).nextLine();
        }
        try (FileReader r = new FileReader(fileName)) {
            NQJFrontend frontend = new NQJFrontend();
            NQJProgram prog = frontend.parse(r);
            System.out.println(prog);

            frontend.getSyntaxErrors().forEach(System.out::println);
        }

    }

    public static NQJProgram parseToAST(String input) throws Exception {
        NQJFrontend parser = new NQJFrontend();
        return parser.parse(new StringReader(input));
    }
}
