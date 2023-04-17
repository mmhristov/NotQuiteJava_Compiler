package notquitejava.translation;

import org.junit.AfterClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.io.File;
import java.io.FileFilter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.*;


/**
 * Runs the Parser on files from the folder testdata/parser.
 * <p>
 * Files from testdata/parser/ok are expected to produce no syntax error.
 * Files from testdata/parser/error are expected to contain syntax errors.
 */
@RunWith(Parameterized.class)
public class FileTranslationTest {


	/**
	 * The text file to parseFile.
	 */
	private final File inputFile;

	public FileTranslationTest(File inputFile) {
		this.inputFile = inputFile;
	}

	@Test
	public void testTranslation() throws Exception {
		String input = Files.readString(inputFile.toPath());
		TranslationTestHelper.testLLVMTranslation(inputFile.getName(), input);
	}

	@Parameterized.Parameters(name = "{0}")
	public static Collection<Object[]> data() {
		ArrayList<Object[]> ctorParams = new ArrayList<>();

		Arrays.stream(Objects.requireNonNull(new File("testdata/translation")
                .listFiles(File::isDirectory)))
                .forEach(file -> appendTestCasesFromDir(file, ctorParams)
        );
		return ctorParams;
	}


	/**
	 * Helper function to fill a list of constructor args with data gained from
	 * file names in a directory
	 *
	 * @param testDataDir the directory whose files should be parsed
	 * @param ctorParams  the growing list to be one day returned by {@link #data()}
	 */
	private static void appendTestCasesFromDir(File testDataDir, ArrayList<Object[]> ctorParams) {
		if (testDataDir.exists()) {
			if (testDataDir.isDirectory()) {
				File[] files = testDataDir.listFiles();
				Arrays.sort(files, Comparator.comparing(File::length));
				for (File f : files) {
					if (f.isFile()) {
						ctorParams.add(new Object[]{f});
					}
				}
			} else {
				// yes, RuntimeException is dirty technique, but this is just
				// a simple test case.
				throw new RuntimeException(String.format(
						"Cannot derive translation test from %s: not a directory",
						testDataDir.getAbsolutePath()));
			}
		}
	}

	@AfterClass
	public static void writeLaunchConfig() throws Exception {
		TranslationTestHelper.setupVscodeLaunch();
	}
}
