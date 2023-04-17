int main() {
		A x;
		x = new A();
		x = x.m();
		return 0;
}

class A {
	A m() {
		return this;
	}
}
