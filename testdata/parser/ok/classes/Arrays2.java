int main() {
		A a;
		a = new A();
		printInt(a.print());
		printInt(a.sort());
		printInt(a.laenge());
		return 0;
}

class A {

	int[] g;

	int print() {
		int[] array;
		array = new int[3];
		array[0] = 5;
		array[1] = 6;
		printInt(array[0]);
		printInt(array[1]);
		return 0;
	}

	int sort() {
		int[] array;
		array = new int[3];
		array[0] = 6;
		array[1] = 5;
		printInt(array[0]);
		printInt(array[1]);
		return 0;
	}

	int laenge() {
		int[] array2;
		array2 = new int[7];
		g = new int[9];
		g[5] = 99;
		array2[2] = 22;
		return array2[2];
	}
}
