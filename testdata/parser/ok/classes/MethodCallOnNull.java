/**
 * Call method on a null instance. Expect ERROR.
 * 
 * @author anton
 *
 */
int main() {
		Bla z;
		int x;
		printInt(1);
		z = new Bla();
		printInt(2);
		x = z.eins();
		return 0;
}

class Bla {
	Bla field;

	int eins() {
		printInt(3);
		return field.zwei(); // field=null, but we don't know that yet
	}

	int zwei() {
		printInt(666);
		return 2;
	}
}
