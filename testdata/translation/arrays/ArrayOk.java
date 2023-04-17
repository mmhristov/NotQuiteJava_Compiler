int main() {
		int[] arr;
		arr = new int[4];
		arr[0] = 100;
		arr[1] = 101;
		arr[2] = 102;
		arr[3] = 103;
		printInt(arr[0]);
		printInt(arr[1]);
		printInt(arr[2]);
		printInt(arr[3]);
		printInt(arr.length); // should not have been overwritten!
		return 0;
}
