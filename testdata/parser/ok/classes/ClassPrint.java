int main() {
		int x;
		x = new A().print();
		printInt(1 + x);
		return 0;
}

class A {
	int print() {
		printInt(1);
		return 0;
	}
}