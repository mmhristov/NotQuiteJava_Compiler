/** And in a while condition */
int main() {
		int i;
		boolean doContinue;
		doContinue = true;
		i = 0;
		printInt(100);
		while (doContinue) { // three iterations
			printInt(i);
			i = i + 1;
			doContinue = i < 3;
		}
		printInt(101);
		return 0;
}