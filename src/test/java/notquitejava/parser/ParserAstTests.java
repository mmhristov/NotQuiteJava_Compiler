package notquitejava.parser;

import frontend.AstPrinter;
import frontend.NQJFrontend;
import frontend.SyntaxError;
import notquitejava.ast.NQJElement;
import notquitejava.ast.NQJMethodCall;
import notquitejava.ast.NQJProgram;
import org.hamcrest.CoreMatchers;
import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertFalse;


public class ParserAstTests {

	@Test
	public void testMinimalProg() throws Exception {
		String input = "int main() {  return 0; }";
		new NQJFrontend().parseString(input);
	}

	@Test
	public void testPrint() throws Exception {
		String input = "int main() { printInt(42); return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("printInt(42);"));
	}

	@Test
	public void testLocalVar() throws Exception {
		String input = "int main() { boolean x; return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("boolean x;"));
	}

	@Test
	public void testAssignment() throws Exception {
		String input = "int main() { int x; x = 5; return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("x = 5;"));
	}

	@Test
	public void testIfStmt() throws Exception {
		String input = "int main() { int x; if (true) x=5; else x = 7; return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("if (true) x = 5;"));
		Assert.assertThat(printed, CoreMatchers.containsString("else x = 7;"));
	}

	@Test
	public void testWhileStmt() throws Exception {
		String input = "int main() { int x; while (x < 10) x=x+1; return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("while ((x < 10)) x = (x + 1);"));
	}

	@Test
	public void operators() throws Exception {
		String input = "int main() { boolean x; x = ((((3 * 4) + 5) < 2) && (1 < 3)); return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("x = ((((3 * 4) + 5) < 2) && (1 < 3))"));
	}

	@Test
	public void operatorPrecedence() throws Exception {
		String input = "int main() { boolean x; x = 3*4+5 < 2 && 1 < 3; return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("x = ((((3 * 4) + 5) < 2) && (1 < 3))"));
	}

	@Test
	public void operatorAssociativity() throws Exception {
		String input = "int main() { boolean x; x = 10 - 5 -3; return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("x = ((10 - 5) - 3)"));
	}

	@Test
	public void operatorPrecedenceMethodCallAndArrays() throws Exception {
		String input = "int main() { boolean x; x = bar[1].foo; return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("x = bar[1].foo"));
	}

	@Test
	public void operatorPrecedenceUnaryAndFields() throws Exception {
		String input = "int main() { int x; x = - bar.foo(); return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		ast.accept(new NQJElement.DefaultVisitor() {
			@Override
			public void visit(NQJMethodCall node) {
				Assert.assertEquals("bar.foo()", AstPrinter.print(node));
			}
		});
	}

	@Test
	public void newObjectStatement() throws Exception {
		String input = "int main() { new C(); return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("new C();"));
	}

	@Test
	public void operatorPrecedenceUnary() throws Exception {
		String input = "int main() { boolean x; x = - - ! - ! - 5; return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("x = (- (- (! (- (! (- 5))))))"));
	}

	@Test
	public void arrayLength() throws Exception {
		String input = "int main() { int x; x = new int[5].length; return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("x = (new int[5]).length"));
		;
	}

	@Test
	public void arrayAccess() throws Exception {
		String input = "int main() { int x; x = new int[5][2]; return 0; }";
		NQJFrontend frontend = new NQJFrontend();
		frontend.parseString(input);
		assert(frontend.getSyntaxErrors().isEmpty());
	}

	@Test
	public void testMultipleFunctions() throws Exception {
		String input = "int main() { return 0; } boolean test(int value) { return !(value == 0); }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("boolean test(int value)"));
	}

	@Test
	public void testFunctionCall() throws Exception {
		String input = "int main() { return getter(); } int getter() { return 42; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("return getter"));
	}

	@Test
	public void testMultipleClasses() throws Exception {
		String input = "int main() { return 0; } class A{} class B{} class C{}";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("class A"));
		Assert.assertThat(printed, CoreMatchers.containsString("class B"));
		Assert.assertThat(printed, CoreMatchers.containsString("class C"));
	}

	@Test
	public void testFunctionsAndClassesAlternate() throws Exception {
		String input = "int main() { return 0; } class A{} int foo() { return 41; } class B{} class C{}";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("int main"));
		Assert.assertThat(printed, CoreMatchers.containsString("class A"));
		Assert.assertThat(printed, CoreMatchers.containsString("int foo"));
		Assert.assertThat(printed, CoreMatchers.containsString("class B"));
		Assert.assertThat(printed, CoreMatchers.containsString("class C"));
	}

	@Test
	public void testMultipleParameters() throws Exception {
		String input = "int main() { return 0; } class A{ int m(int a, boolean b, int c){return 0;}}";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("int m(int a, boolean b, int c)"));
	}

	@Test
	public void testMultipleArgumetns() throws Exception {
		String input = "int main() {x=a.s(1,2,f+g); return 0; }";
		NQJProgram ast = new NQJFrontend().parseString(input);
		String printed = AstPrinter.print(ast);
		Assert.assertThat(printed, CoreMatchers.containsString("x = a.s(1, 2, (f + g));"));
	}

}
