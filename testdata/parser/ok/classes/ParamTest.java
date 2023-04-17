int main() {
		A x;
		x = new A();
		x = x.m(0);
		return 0;
}

class A {
	A m(int i) {
		return new A();
	}

}
