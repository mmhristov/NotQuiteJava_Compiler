int main() {
		A a;
		a = new A();
		printInt(a.print(5));
		printInt(a.sort());
		printInt(a.laenge());
		return 0;
}

class A {
	int[] array;

	int print(int s) {
		array = new int[2];
		array[0] = 5;
		array[1] = 6;
		printInt(array[0]);
		printInt(array[1]);
		return 0;
	}

	int sort() {
		array[0] = 6;
		array[1] = 5;
		printInt(array[0]);
		printInt(array[1]);
		return 0;
	}

	int laenge() {
		return new int[88 + 88].length;
	}
}
