int main() {
		int[][][] arr;
		arr = new int[2][][];
		int[] x;
		arr[1] = new int[2][];
		arr[1][1] = new int[2];
		arr[1][1][1] = 1;
		printInt(arr[1][1][0]);
		printInt(arr[1][1][1]);
		printInt(arr.length);
		return 0;
}
