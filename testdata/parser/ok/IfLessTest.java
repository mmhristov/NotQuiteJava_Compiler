/**
 * Test if-statement and less-operator.
 * 
 * @author anton
 *
 */
int main() {
		if (1 < 2) {
			printInt(1);
		} else {
			printInt(666);
		}
		if (2 < 1) {
			printInt(999);
		} else {
			printInt(2);
		}
		if (1 < 1) {
			printInt(999);
		} else {
			printInt(3);
		}
		printInt(4);
		return 0;
}