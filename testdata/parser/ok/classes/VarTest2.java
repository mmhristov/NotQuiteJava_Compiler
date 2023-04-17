int main() {
		return 0;
}

class A {
	int x;
}

class B extends A {
}

class C extends B {
	boolean x;

	boolean m() {
		return x;
	}

}