int main() {
		int[][] arr;
		arr = new int[2][];
		int[] x;
		x = new int[2];
		arr[0] = x;
		arr[1] = x;
		arr[0][0] = 1;
		arr[0][1] = 1;
		arr[1][0] = 1;
		arr[1][1] = 1;
		printInt(arr[0][0]);
		printInt(arr[0][1]);
		printInt(arr[1][0]);
		printInt(arr[1][1]);
		printInt(arr.length);
		return 0;
}

int f() {
	return 42;
}
