package notquitejava.translation;


import org.junit.AfterClass;
import org.junit.Test;

public class SimpleTests {

    @Test
    public void empty() throws Exception {
        testStatements(
                ""
        );
    }
	@Test
	public void println() throws Exception {
		testStatements(
				"printInt(42);"
		);
	}

	@Test
	public void test0() throws Exception {
		testStatements(
				"printInt(42 * 7 + 3);"
		);
	}

	@Test
	public void test1() throws Exception {
		testStatements(
				"int x;",
				"x = 42;",
				"x = x + 1;",
				"printInt(x);"
		);
	}


	@Test
	public void test2() throws Exception {
		testStatements(
				"int x;",
				"x = 42;",
				"while (0 < x) {",
				"	printInt(x);",
				"	x = x - 1;",
				"}"
		);
	}

	private void testStatements(String...inputLines) throws Exception {
		String input = "int main() {\n"
				+ String.join("\n", inputLines)
				+ "\nreturn 0;\n}\n";
		TranslationTestHelper.testLLVMTranslation("Test.java", input);
	}

	@AfterClass
	public static void writeLaunchConfig() throws Exception {
		TranslationTestHelper.setupVscodeLaunch();
	}
}
