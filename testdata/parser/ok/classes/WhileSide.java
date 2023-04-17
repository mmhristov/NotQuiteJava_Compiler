int main() {
		int i;
		Count c;
		// OK

		c = new Count();
		i = 0 * c.init(10) * 0;
		while (i < c.value()) {
			printInt(i);
			i = i + 1;
		}
		return 0;
}

class Count {
	int x;

	int init(int val) {
		x = val;
		return x;
	}

	int value() {
		x = x - 1;
		return x;
	}
}
