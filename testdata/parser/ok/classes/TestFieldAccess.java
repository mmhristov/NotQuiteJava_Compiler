int main() {
		BB bb;
		bb = new BB();
		bb.aa= new AA();
		bb.aa.arr = new int[2];
		bb.getAA().getArr()[0] = 5;
		bb.aa.getArr()[1] = 10;
		printInt(bb.getAA().arr[0]);
		return 0;
}

class AA {
	
	int[] arr;
	int[] getArr(){
		return arr;
	}
}

class BB {
	AA aa;
	AA getAA(){
		return aa;
	}
}
