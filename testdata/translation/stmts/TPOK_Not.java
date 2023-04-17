int main() {
		int a;
		{
			a = 4 + 1;
			if (!(4 < a)) {
				printInt(11);
			} else {
				printInt(22);
			}
		}
		printInt(a);
		return 0;
}
