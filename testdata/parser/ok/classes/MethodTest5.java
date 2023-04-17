int main() {
		B x;
		A y;
		x = new B();
		y = x.m();
		return 0;
}

class A {
	A m() {
		return new A();
	}

}

class B extends A {
}