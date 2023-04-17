/** And in a while condition */
int main() {
		int i;
		i = 0;
		printInt(100);
		while ((i < 4) && (i < 3)) { // three iterations
			printInt(i);
			i = i + 1;
		}
		printInt(101);
		return 0;
}