int main() {
		return 0;
}

class A {
	A m(boolean x) {
		return new A();
	}
}

class B extends A {
	B m(boolean x) { // legal (JLS3, 8.4.8.3)
		return new B();
	}
}
