// Prints "0".  And nothing else!!!

int main() {
		printInt(new TestAnd().run(false));
		return 0;
}

class TestAnd {

	int run(boolean b) {
		int result;
		if (b && this.sideEffect())
			result = 1;
		else
			result = 0;
		return result;
	}

	boolean sideEffect() {
		printInt(0 - 9999);
		printInt(0 - 9999);
		printInt(0 - 9999);
		printInt(0 - 9999);
		printInt(0 - 9999);
		return true;
	}

}