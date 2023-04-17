int main() {
		return 0;
}

class A {
	A m(boolean x) {
		return new A();
	}
}

class B {
	A m(int x) {
		return new A();
	}
}
