int main() {
		int drei;
		int vier;
		drei = 3;
		vier = 2 * 2 * 1 * 1;
		if (drei < vier) {
			printInt(drei);
		} else {
			printInt(vier);
		}
		if (vier < drei) {
			printInt(44 * vier);
			drei = 0;
			vier = 27;
		} else
			printInt(0);
		printInt(drei * vier);
		return 0;
}
