int main() {
		printInt(new TestEqMain().run());
		return 0;
}

class TestEqMain {
	int run() {
		boolean b;
		b = 4 < 4 + 1 && 4 < 4 + 1;
		if (b) {
			printInt(1);
		} else {
			printInt(0);
		}
		return 0;
	}
}
