int main() {
		myClass a;
		boolean foolean;
		a = new myClass();
		foolean = a.SetVal(111);
		printInt(a.GetVal());
		return 0;
}

class myClass {
	int a;
	int b;

	boolean SetVal(int arrg) {
		a = arrg;
		return true;
	}

	int GetVal() {
		return a;
	}
}
