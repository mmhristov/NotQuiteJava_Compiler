/**
 * Test the not-expression, without observing side-effects.
 * 
 * @author anton
 *
 */
int main() {
		if (!(1 < 2)) {
			printInt(666);
		} else {
			printInt(1);
		}
		if (!(2 < 1)) {
			printInt(2);
		} else {
			printInt(999);
		}
		return 0;
}