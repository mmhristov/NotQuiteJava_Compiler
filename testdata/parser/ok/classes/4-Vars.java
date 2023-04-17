int main() {
		printInt(new A().run());
		return 0;
}

class A {
	int run() {
		int a;
		int b;
		a = this.helper(12);
		b = this.helper(15);
		return a + b;
	}

	int helper(int param) {
		int x;
		x = param;
		param = param + 1;
		printInt(x);
		return x;
	}
}
