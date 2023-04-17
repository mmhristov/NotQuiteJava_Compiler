int main() {
		printInt(new Eins().GetVal());
		printInt(new Zwei().GetVal());
		return 0;
}

class Eins {
	int GetVal() {
		return 1;
	}
}

class Zwei extends Eins {
	int GetVal() {
		return 2;
	}
}
