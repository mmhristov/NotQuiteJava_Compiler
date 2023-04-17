int main() {
		int foo;
		B b;
		b = new B();
		printInt(1);
		foo = b.someMethod();
		printInt(2);
		return 0;
}

class B {
	int x;
	boolean y;

	int someMethod() {
		if (y) {
			printInt(667);
		} else {
			printInt(x);
		}
		return 666;
	}
}