int main() {
		printInt(new AA().run());
		return 0;
}

class AA {

	int run() {

		int[] arr;

		arr = new int[2];

		arr[0] = 5;
		arr[1] = 10;
		return arr[0];

	}

}