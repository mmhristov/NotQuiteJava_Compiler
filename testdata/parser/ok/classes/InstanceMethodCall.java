/**
 * Instance method calls with one parameter and one return value. Field access
 * read, write. No overriding yet.
 * 
 * @author anton
 *
 */
int main() {
		Zahl z;
		int ignore;
		z = new Zahl();
		ignore = z.set(1);
		printInt(z.get());
		ignore = z.set(2);
		ignore = z.print();
		return 0;
}

class Zahl {
	int theZahl;

	int set(int x) {
		theZahl = x;
		return 667;
	}

	int get() {
		return theZahl;
	}

	int print() {
		printInt(theZahl);
		return 666;
	}
}