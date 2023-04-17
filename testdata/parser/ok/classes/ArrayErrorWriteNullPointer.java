int main() {
		Bla bla;
		int dummy;
		bla = new Bla();
		printInt(1);
		dummy = bla.writeUninitializedArray();
		printInt(2);
		return 0;
}

class Bla {
	int[] array;

	int readUninitializedArray() {
		return array[0];
	}

	int writeUninitializedArray() {
		array[0] = 1;
		return 1;
	}

	int lengthOfUninitializedArray() {
		return array.length;
	}
}