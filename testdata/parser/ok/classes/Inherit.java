int main() {
		B b;
		C c;
		b = new B();
		c = new C();
		printInt(b.change());
		printInt(c.change());
		printInt(b.bla());
		printInt(c.get());
		return 0;
}

class A {
	int i;
	int j;

	int print() {
		return 8;
	}

	int change() {
		i = 7;
		return 0;
	}
}

class B extends A {

	int blubb() {
		return 1;
	}

	int bla() {
		i = i + 1;
		return i;
	}

}

class C {
	int i;

	int change() {
		i = 99;
		return 0;
	}

	int get() {
		return i;
	}
}