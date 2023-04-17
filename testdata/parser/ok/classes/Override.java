int main() {
		Base a;
		a = new Random();
		printInt(a.function());
		printInt(a.init());
		printInt(a.function());
		return 0;
}

class Base {
	int x;
	int y;

	int init() {
		x = 1;
		y = 5;
		return x;
	}

	int function() {
		return 8888;
	}
}

class Random extends Base {
	int x;

	int function() {
		int z;
		z = x + y;
		return z;
	}
}
