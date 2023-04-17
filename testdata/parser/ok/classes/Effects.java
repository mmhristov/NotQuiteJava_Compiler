// Test correct translation of side effects

int main() {
		printInt(new EffectsClass().run());
		return 0;
}

class EffectsClass {

	int run() {
		Bit b;
		b = new Bit();
		return ((b.set(1) - 1) - (b.set(0) - (0 - b.value())));
		// returns 0
	}
}

class Bit {

	int bit;

	int set(int b) {
		bit = b;
		return b;
	}

	int value() {
		return bit;
	}

}