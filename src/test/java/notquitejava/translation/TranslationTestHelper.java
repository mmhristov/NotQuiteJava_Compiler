package notquitejava.translation;

import main.NotQuiteJavaCompiler;
import nqjtooling.transpiler.main.NQJTranspiler;
import notquitejava.ast.NQJProgram;
import minillvm.analysis.Checks;
import minillvm.ast.Prog;
import org.junit.Assert;

import javax.tools.JavaCompiler;
import javax.tools.ToolProvider;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.charset.StandardCharsets;
import java.nio.file.FileVisitResult;
import java.nio.file.FileVisitor;
import java.nio.file.Path;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.Collections;
import java.util.Map;

import static org.junit.Assert.assertEquals;

public class TranslationTestHelper {

	public static final String LLVM_LLI_EXE;
	public static final String LLVM_OPT_EXE;
	public static final String LLVM_LLC_EXE;
	public static final String CC_EXE;
	public static final String EXE_SUFFIX;

	private final static int mipsTimeOut = 10000;
	private static File testOutputFolder = new File("testoutput");
	private static File debugOutputFolder = new File("testoutput/debug");
	static {
		Map<String, String> env = System.getenv();
		if (env.containsKey("LLVM_COMPILER_PATH")) {
			String LLVM_BASE = env.get("LLVM_COMPILER_PATH");
			LLVM_LLI_EXE = Paths.get(LLVM_BASE, "lli").toString();
			LLVM_OPT_EXE = Paths.get(LLVM_BASE, "opt").toString();
			LLVM_LLC_EXE = Paths.get(LLVM_BASE, "llc").toString();
		} else {
			LLVM_LLI_EXE = "lli";
			LLVM_OPT_EXE = "opt";
			LLVM_LLC_EXE = "llc";
		}
		if (env.containsKey("CC")) {
			CC_EXE = env.get("CC");
		} else {
			CC_EXE = "gcc";
		}
		if (System.getProperty("os.name").contains("win")) {
			EXE_SUFFIX = ".exe";
		} else {
			EXE_SUFFIX = "";
		}
		testOutputFolder.mkdirs();
		debugOutputFolder.mkdirs();

		try {
			Files.walkFileTree(debugOutputFolder.toPath(), new SimpleFileVisitor<Path>() {
				@Override
				public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
					Files.delete(file);

					return FileVisitResult.CONTINUE;
				}

				@Override
				public FileVisitResult visitFileFailed(Path file, IOException exc) throws IOException {
					if (file.toString().contains(".vscode")) {
						return FileVisitResult.TERMINATE;
					}
					return FileVisitResult.CONTINUE;
				}
			});

			new File("testoutput/debug/.vscode").mkdirs();
			Files.write(new File("testoutput/debug/.vscode/settings.json").toPath(), "{ \"debug.allowBreakpointsEverywhere\": true }".getBytes());
		} catch (IOException e) {
			System.err.println("Error setting up VSCode Workspace for debugging.");
		}

	}

	/**
	 * Normalizes line endings to Unix style
	 * @param input the input with mixed line endings
	 * @return the input with only Unix newline line endings
	 */
	public static String normalize(String input) {
		return input.replaceAll("\r\n", "\n");
	}


	public static void testLLVMTranslation(String inputName, String miniJavaProgram) throws Exception {
		NotQuiteJavaCompiler compiler = new NotQuiteJavaCompiler();
		compiler.compileString(inputName, miniJavaProgram);
		assertEquals(Collections.emptyList(), compiler.getSyntaxErrors());
		assertEquals(Collections.emptyList(), compiler.getTypeErrors());
		NQJProgram program = compiler.getJavaProgram();
		Prog llvmProg = compiler.getLlvmProg();

		String llvmOut = llvmProg.toString();

		File llvmOutFile = new File(testOutputFolder, inputName.replace(".java", "") + ".ll");
		Files.write(llvmOutFile.toPath(), llvmOut.getBytes(StandardCharsets.UTF_8));

		// check llvm prog
		new Checks().checkProgram(llvmProg);

		// get some input for testing the program
		String programInput = randomInput();

		// run java program and record the output
		String javaOutput = "";
		Throwable runtimeErrorInJava = null;
		try {
			javaOutput = runJavaProgAndGetOut(inputName, miniJavaProgram, programInput);
		} catch (InvocationTargetException ex) {
			runtimeErrorInJava = ex.getCause();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		// verify the llvm program with
		verifyLlvm(llvmProg);
		// run the llvm program and compare its output with the output of Java
		try {
			String llvmOutput = runLlvmCodeAndGetoutput(llvmProg, programInput);
			Assert.assertEquals(javaOutput, llvmOutput);
			if (runtimeErrorInJava != null) {
				Assert.fail("Java program stopped with runtime error '" + runtimeErrorInJava + "', but LLVM stopped normally.");
			}
		} catch (ProgramExecutionException e) {
			if (e.exitCode == 222) { // special error code returned by LLVM-error instruction
				Assert.assertNotNull("Llvm interpreter gave error, but there should be no error.\nOutput: \n" + e.getOutput(), runtimeErrorInJava);
			} else {
				compileLlvm(llvmProg, inputName.replace(".java", ""));
				throw e;
			}
		}

	}

    private static String randomInput() {
		return "*random";
	}

	private static String runJavaProgAndGetOut(String inputName, String miniJavaProgram, String input) throws Exception {
		File tempDir = new File("temp/");
		File tempFile = new File(tempDir, inputName);
		tempDir.mkdirs();
		try {
			File fakeSystem = createFakeSystemFile(tempDir);
			String javaProgram = NQJTranspiler.transform(miniJavaProgram);
			File file = createJavaFile(tempDir, inputName, javaProgram);
			Files.copy(file.toPath(), tempFile.toPath());

			JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
			// TODO: figure out if we can remove the fakeSystem file
			compiler.run(null, null, null, tempFile.getAbsolutePath(), fakeSystem.getAbsolutePath());

			URLClassLoader classLoader = URLClassLoader
					.newInstance(new URL[] { tempDir.toURI().toURL() });
			Class<?> cls = Class.forName(NQJTranspiler.globalClassName, true, classLoader);
			Method main = cls.getDeclaredMethod("main", new String[]{}.getClass());
			if (!main.isAccessible()) {
				main.setAccessible(true);
			}

			PrintStream originalOut = System.out;
			InputStream originalIn = System.in;
			try {
				ByteArrayOutputStream os = new ByteArrayOutputStream();
				PrintStream ps = new PrintStream(os);
				System.setOut(ps);
				System.setIn(new ByteArrayInputStream(input.getBytes()));

				main.invoke(null, new Object[]{new String[]{}});
				return normalize(os.toString());
			} finally {
				System.setOut(originalOut);
				System.setIn(originalIn);
			}
		} finally {
			tempFile.delete();
		}
	}

	private static File createJavaFile(File tempDir, String inputName, String miniJavaProgram) throws IOException {
		File f = new File(tempDir, inputName);
		if (f.exists()) {
			f.delete();
		}
		Files.write(f.toPath(), miniJavaProgram.getBytes(StandardCharsets.UTF_8));
		return f;
	}

	private static File createFakeSystemFile(File tempDir) throws FileNotFoundException {
		File f = new File(tempDir, "System.java");
		if (f.exists()) {
			f.delete();
		}

		try (PrintWriter writer = new PrintWriter(f)) {
			writer.println("public class System {");
			writer.println("	public static Out out = new Out();");
			writer.println("	public static In in = new In();");
			writer.println("	public static class Out {");
			writer.println("		public void println(int i) {");
			writer.println("			java.lang.System.out.println(i);");
			writer.println("		}");
			writer.println("	}");
			writer.println("	public static class In {");
			writer.println("		public int read() {");
			writer.println("			try {");
			writer.println("				return java.lang.System.in.read();");
			writer.println("			} catch (java.io.IOException e) {");
			writer.println("				return -1;");
			writer.println("			}");
			writer.println("		}");
			writer.println("	}");
			writer.println("}");
		}
		return f;
	}

	private static void verifyLlvm(Prog llp) throws IOException, InterruptedException {
		byte[] code = llp.toString().getBytes();
		try {
			runProgram(new ProcessBuilder(LLVM_OPT_EXE, "-verify"), code);
		} catch (ProgramExecutionException e) {
			throw new RuntimeException("The LLVM verifier found a problem : \n"  + new String(e.errs));
		}
	}

	public static String runLlvmCodeAndGetoutput(Prog llp, String programInput) throws Exception {
		byte[] code = llp.toString().getBytes();
		File tempFile = File.createTempFile("llvm", "ll");
		Files.write(tempFile.toPath(), code);
		byte[] output = runProgram(new ProcessBuilder(LLVM_LLI_EXE, tempFile.getAbsolutePath()), programInput.getBytes());
		return normalize(new String(output));
	}

	public static void compileLlvm(Prog llp, String name) throws Exception {
		byte[] code = llp.toString().getBytes();
		File llFile = new File(debugOutputFolder, name + ".ll");
		File objFile = new File(debugOutputFolder, name + ".o");
		File exeFile = new File(debugOutputFolder, name + EXE_SUFFIX);

		Files.write(llFile.toPath(), code);

		runProgram(new ProcessBuilder(LLVM_LLC_EXE, "-O0", "--filetype=obj", "-o", objFile.getAbsolutePath(), llFile.getAbsolutePath()), new byte[0]);
		runProgram(new ProcessBuilder(CC_EXE, "-g", "-o", exeFile.getAbsolutePath(), objFile.getAbsolutePath()), new byte[0]);

		Files.delete(objFile.toPath());
	}

	public static void setupVscodeLaunch() throws Exception {
		String configs = String.join(", ", (Iterable<String>) Files.list(debugOutputFolder.toPath())
		.filter(p -> !p.toFile().isDirectory() && p.toString().endsWith(".ll"))
		.map(p -> p.getFileName().toString().replace(".ll", ""))
		.map(p -> "{ \"type\": \"lldb\", \"request\": \"launch\", \"name\": \"" + p + "\", \"program\": \"${workspaceFolder}/" + p + "\", \"expressions\": \"simple\" }")
		::iterator);
		String launch = "{ \"version\": \"0.2.0\", \"configurations\": [" + configs + "]}";
		Files.write(new File("testoutput/debug/.vscode/launch.json").toPath(), launch.getBytes());
	}

	private static byte[] runProgram(ProcessBuilder pb, byte[] stdin)
			throws IOException, InterruptedException, ProgramExecutionException {
		Process p = pb.start();
		p.getOutputStream().write(stdin);
		p.getOutputStream().close();
		int res = p.waitFor();
		byte[] output = bytesFromInput(p.getInputStream());
		byte[] errs = bytesFromInput(p.getErrorStream());
//		System.out.println("output of " + pb.command());
//		System.out.println(new String(output));
//		System.out.println("output errors of " + pb.command());
//		System.out.println(new String(errs));
		if (res != 0) {
			throw new ProgramExecutionException(res, output, errs, "could not complete tool " + pb.command()
					+ ", exit code: " + res);
		}
		return output;
	}

	static class ProgramExecutionException extends Exception {
		private int exitCode;
		private byte[] output;
		private byte[] errs;

		public ProgramExecutionException(int exitCode, byte[] output, byte[] errs, String msg) {
			super(msg);
			this.exitCode = exitCode;
			this.output = output;
			this.errs = errs;
		}

		@Override
		public String toString() {
			String msg = getMessage();
			msg += "\nExit code: " + exitCode;
			if (errs.length > 0) {
				msg += "\nErrors: " + new String(errs);
			} else if (output.length > 0) {
				msg += "\nOutput: " + new String(output);
			}
			return msg;
		}

		public String getOutput() {
			return new String(output, StandardCharsets.UTF_8);
		}
	}

	private static byte[] bytesFromInput(InputStream is) throws IOException {
		ByteArrayOutputStream buffer = new ByteArrayOutputStream();

		int nRead;
		byte[] data = new byte[16384];

		while ((nRead = is.read(data, 0, data.length)) != -1) {
			buffer.write(data, 0, nRead);
		}

		buffer.flush();

		return buffer.toByteArray();
	}
}
