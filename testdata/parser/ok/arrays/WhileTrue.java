int main() {
		int i;
		int[] arr;
		i = 0;
		arr = new int[3];
		while (true) {
			arr[i] = 0; // will ERROR later to break out of the loop
			printInt(i);
			i = i + 1;
		}
		return 0;
}