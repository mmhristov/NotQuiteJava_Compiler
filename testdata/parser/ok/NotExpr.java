/**
 * Not-operator in an expression, not in the condition of an if.
 * 
 * @author anton
 *
 */
int main() {
		boolean a;
		boolean b;
		a = true;
		b = !a;
		if (b) {
			printInt(666);
		} else {
			printInt(1);
		}
		return 0;
}