int main() {
		printInt(new WhileClass().run());
		return 0;
}

class WhileClass {
	int run() {
		int i;
		int sum;

		sum = 0;
		i = 1;
		while (i < 11) {
			sum = sum + i;
			printInt(sum);
			i = i + 1;
		}
		return 0;
	}
}
