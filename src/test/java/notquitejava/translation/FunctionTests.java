package notquitejava.translation;


import org.junit.AfterClass;
import org.junit.Test;

import java.util.List;
import java.util.stream.Stream;

public class FunctionTests {

	@Test
	public void call1() throws Exception {
		testStatements(
		        List.of("int get() {return 44;}"),
				"printInt(get());"
		);
	}

    @Test
    public void call2() throws Exception {
        testStatements(
                List.of("int get() {return 44;}"),
                "int x;"
                , "x = get();"
                , "printInt(20);"
        );
    }

    @Test
    public void call3() throws Exception {
        testStatements(
                List.of(
                        "int get() {return 44;}",
                        "int get2() {return 1+get();}"
                ),
                "int x;"
                , "x = get2();"
                , "printInt(x);"
        );
    }

    @Test
    public void call4() throws Exception {
        testStatements(
                List.of(
                        "int get() {return 44;}",
                        "int get2() {return 1+get();}"
                ),
                "int x;"
                , "x = get2();"
                , "printInt(x + get2() + get());"
        );
    }

    @Test
    public void callParams() throws Exception {
        testStatements(
                List.of(
                        "int get(int a) {return 44 + a;}"
                ),
                "int x;"
                , "x = get(200);"
                , "printInt(x);"
        );
    }

    @Test
    public void callParams2() throws Exception {
        testStatements(
                List.of(
                        "int get(int a, int b, int c) {return 44 * b * c + a;}"
                ),
                "int x;"
                , "x = get(200, 20, 10);"
                , "printInt(x + 10);"
        );
    }

	private void testStatements(List<String> procs, String...inputLines) throws Exception {
		String input = String.join("\n", procs)
                + "int main() {\n"
                + String.join("\n", inputLines)
                + "\nreturn 0;\n}\n";
        TranslationTestHelper.testLLVMTranslation("Test.java", input);
	}

	@AfterClass
	public static void writeLaunchConfig() throws Exception {
		TranslationTestHelper.setupVscodeLaunch();
	}
}
