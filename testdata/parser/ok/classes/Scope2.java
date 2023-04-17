// Should return 5

int main() {
		printInt(new S().run(5, 10));
		return 0;
}

class S {

	int n;

	int Init(int m) {
		n = m;
		return 0;
	}

	int run(int n, int m) {
		int k;
		k = this.Init(m);
		return n;
	}

}