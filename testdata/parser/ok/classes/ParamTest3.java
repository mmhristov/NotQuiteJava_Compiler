int main() {
		A x;
		B y;
		x = new A();
		y = new B();
		x = x.m(y);
		return 0;
}

class A {
	A m(A x) {
		return new A();
	}

}

class B extends A {
}
