int main() {
		int i;
		Loud loud;
		loud = new Loud();

		i = 1;
		while (loud.withSideEffect(i, 0) < 5) {
			printInt(i);
			i = i + 1;
		}
		printInt(100);
		return 0;
}

class Loud {
	int withSideEffect(int x, int printee) {
		printInt(printee);
		return x;
	}
}