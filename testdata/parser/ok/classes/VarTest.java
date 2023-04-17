int main() {
		return 0;
}

class A {
	int x;
}

class B extends A {
}

class C extends B {
	int m() {
		return x;
	}

}