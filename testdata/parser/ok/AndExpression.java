/** And in an expression context */
int main() {
		boolean z;
		boolean wahr;
		wahr = true;
		z = wahr && false;
		if (z) {
			printInt(666);
		} else {
			printInt(1);
		}

		z = wahr && true;
		if (z) {
			printInt(2);
		} else {
			printInt(667);
		}
		return 0;
}
