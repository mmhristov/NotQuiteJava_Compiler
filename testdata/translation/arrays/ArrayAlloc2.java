int main() {
		int[] a1;
		int b;
		b = 3;
		a1 = new int[b * 2];
		a1[b * 2 - 1] = b * 3 + 10;
		printInt(42);
		printInt(a1[4 + 1]);
		return 0;
}
