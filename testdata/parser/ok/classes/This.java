/**
 * The this-object
 * 
 * @author anton
 *
 */
int main() {
		Bla bla;
		Bla blub;
		int dumm;
		bla = new Bla();
		printInt(1);
		dumm = bla.setFeld(2);
		blub = bla.getThis();
		dumm = bla.setFeld(3);
		dumm = blub.printFeld();
		printInt(4);
		return 0;
}

class Bla {
	int feld;

	int setFeld(int x) {
		feld = x;
		return 0;
	}

	Bla getThis() {
		return this;
	}

	int printFeld() {
		return this.doPrintFeld();
	}

	int doPrintFeld() {
		printInt(feld);
		return 0;
	}
}
