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
		return 2;
	}
}
