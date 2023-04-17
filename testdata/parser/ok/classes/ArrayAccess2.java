int main() {
		printInt(new AA().run());
		return 0;
}

class AA {
	
	int[] arr;
	int[] getArr(){
		return arr;
	}
	int run() {

		arr = new int[2];

		arr[0] = 5;
		arr[1] = 10;
		return this.getArr()[0];

	}

}