int main() {
		myClass a;
		a = new myClass();
		printInt(a.tee());
		return 0;
}

class myClass {
	int a;
	int b;

	int tee() {
		int a;
		a = 14;
		return a;
	}
}
