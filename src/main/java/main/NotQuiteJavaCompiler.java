package main;

import analysis.Analysis;
import analysis.TypeError;
import frontend.NQJFrontend;
import frontend.SyntaxError;
import minillvm.ast.Prog;
import notquitejava.ast.NQJProgram;
import translation.Translator;

import java.io.*;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

/**
 * Entry-point for parsing and compiling NQJ files.
 */
public class NotQuiteJavaCompiler {

    private NQJProgram javaProgram;
    private Prog llvmProg;
    private Analysis analysis;
    private NQJFrontend frontend;

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
        NotQuiteJavaCompiler compiler = new NotQuiteJavaCompiler();
        File inputFile = new File(fileName);
        compiler.compileFile(inputFile);

        if (!compiler.getSyntaxErrors().isEmpty() || !compiler.getTypeErrors().isEmpty()) {
            compiler.getSyntaxErrors().forEach(System.out::println);
            compiler.getTypeErrors().forEach(System.out::println);
            System.exit(7);
        }

        compiler.compileLlvmCode(inputFile.getName());
    }

    /**
     * Compiles a file.
     */
    public void compileFile(File file) throws Exception {
        try (FileReader r = new FileReader(file)) {
            compile(file.getPath(), r);
        }

    }

    /**
     * Compiles a string.
     */
    public void compileString(String inputName, String input) throws Exception {
        compile(inputName, new StringReader(input));
    }

    /**
     * Read, typecheck, and translate.
     */
    public void compile(String inputName, Reader input) throws Exception {
        frontend = new NQJFrontend();
        javaProgram = frontend.parse(input);
        if (!frontend.getSyntaxErrors().isEmpty()) {
            return;
        }

        // typecheck
        analysis = new Analysis(javaProgram);
        analysis.check();
        if (!analysis.getTypeErrors().isEmpty()) {
            return;
        }

        // translate
        // TODO you can pass analysis results to your translator here:
        Translator translator = new Translator(javaProgram);
        llvmProg = translator.translate();
    }

    public NQJProgram getJavaProgram() {
        return javaProgram;
    }

    public Prog getLlvmProg() {
        return llvmProg;
    }

    public List<SyntaxError> getSyntaxErrors() {
        return frontend.getSyntaxErrors();
    }

    /**
     * Returns all saved type errors.
     */
    public List<TypeError> getTypeErrors() {
        if (analysis == null) {
            return Collections.emptyList();
        }
        return analysis.getTypeErrors();
    }

    /**
     * Compile to mini llvm code.
     */
    private void compileLlvmCode(String name) throws IOException, InterruptedException {
        File llvmOutFile = new File(name + ".ll");
        Files.writeString(llvmOutFile.toPath(), llvmProg.toString());

        // llvm -> bitcode
        executeCommand("llvm-as", llvmOutFile.getAbsolutePath());

        //  bitcode -> object file
        File llvmBc = new File(name + ".bc");
        executeCommand("llc", "-filetype=obj", llvmBc.getAbsolutePath());

        // link object file
        File objFile = new File(name + ".o");
        executeCommand("clang", "-o", name + ".exe", objFile.getAbsolutePath());
    }

    private void executeCommand(String... args) throws IOException, InterruptedException {
        ProcessBuilder builder = new ProcessBuilder();
        builder.command(args);
        Process process = builder.start();
        int exitCode = process.waitFor();

        String out = readStream(process.getInputStream());
        System.out.println(out);
        String err = readStream(process.getErrorStream());
        System.err.println(err);

        if (exitCode != 0) {
            throw new RuntimeException("Command " + Arrays.toString(args)
                    + " failed with error code " + exitCode);
        }
    }

    private String readStream(InputStream inputStream) {
        Scanner s = new Scanner(inputStream).useDelimiter("\\A");
        return s.hasNext() ? s.next() : "";
    }
}
