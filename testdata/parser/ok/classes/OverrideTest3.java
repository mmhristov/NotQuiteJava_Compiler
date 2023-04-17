int main() {
		// A a;
		// a = new B();
		// printInt(a.m(5));
		printInt((new A()).foo());
		return 0;
}

class A {

	int foo() {
		A a;
		int i;
		i = 3;
		a = new B();
		if (i < 5) {
			printInt(a.m(50));
			i = 10;
		} else {
			printInt(a.m(40));
			i = 12;
		}
		while (i < 100) {
			printInt(i);
			i = i + 3;
		}
		return 11111;
	}

	int m(int x) {
		return x + 1;
	}
}

class B extends A {
	int m(int x) {
		return x + 2;
	}
}
