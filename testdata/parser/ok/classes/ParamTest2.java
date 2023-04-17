int main() {
		A x;
		x = new A();
		x = x.m(0, false);
		return 0;
}

class A {
	A m(int i, boolean b) {
		return new A();
	}

}
