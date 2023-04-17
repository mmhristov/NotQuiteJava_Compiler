int main() {
		boolean falsch;
		falsch = 4 < 1;
		if (falsch && true) {
			printInt(-9);
		} else {
			printInt(11);
		}
		if (!falsch && true) {
			printInt(-7);
		} else {
			printInt(13);
		}

		return 0;
}
