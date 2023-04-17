int main() {
		boolean foolean;
		Penner p;
		Penner p2;
		p = new Bettler();
		p2 = new Penner();
		foolean = p.SetGeld(10);
		foolean = p2.SetGeld(10);
		printInt(p.GetGeld());
		printInt(p2.GetGeld());
		return 0;
}

class Penner {
	int geld;

	int GetGeld() {
		return 2;
	}

	boolean SetGeld(int value) {
		geld = value;
		return true;
	}
}

class Bettler extends Penner {
	int GetGeld() {
		return geld + 10;
	}
}
