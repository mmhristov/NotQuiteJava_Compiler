int main() {
		boolean yes;
		boolean si;
		boolean nie;
		boolean ikke;
		yes = true;
		si = true;
		nie = false;
		ikke = false;
		if (yes && si) {
			printInt(1);
		} else {
			printInt(666);
		}
		if (yes && nie) {
			printInt(667);
		} else {
			printInt(2);
		}
		if (nie && si) {
			printInt(668);
		} else {
			printInt(3);
		}
		if (ikke && nie) {
			printInt(669);
		} else {
			printInt(4);
		}
		// Nested!
		if ((yes && si) && (si && yes)) {
			printInt(5);
		} else {
			printInt(670);
		}
		if ((yes && nie) && (si && yes)) {
			printInt(671);
		} else {
			printInt(6);
		}
		if ((yes && si) && (nie && yes)) {
			printInt(672);
		} else {
			printInt(7);
		}
		if ((yes && si) && (yes && nie)) {
			printInt(673);
		} else {
			printInt(8);
		}
		return 0;
}