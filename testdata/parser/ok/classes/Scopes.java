int main() {
		A a;
		a = new A();
		printInt(a.change());
		printInt(a.marp());
		printInt(a.morp());
		printInt(new A().muh().pong());
		return 0;
}

class A {

	int i;

	int change() {
		B a;
		a = new B();
		i = 5;
		return i;
	}

	int marp() {
		int i;
		A a;
		a = new A();
		i = 7;
		printInt(a.morp());
		return i;
	}

	int morp() {
		B a;
		a = new B();
		printInt(a.peng());
		return i;
	}

	B muh() {
		B a;
		a = new B();
		printInt(a.peng());
		return a;
	}

}

class B {

	A a;

	int peng() {
		a = new A();
		return 99;
	}

	int pong() {
		B b;
		a = new A();
		return a.muh().peng();
	}
}