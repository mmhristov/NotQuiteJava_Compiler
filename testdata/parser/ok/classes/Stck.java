int main() {
		printInt((new StckClass()).stckme(55));
		return 0;
}

class StckClass {
	int stckme(int x) {
		int loc;
		int dummy;
		loc = x;
		if (x < 1) {
			// nothing
		} else {
			dummy = this.stckme(x - 1);
		}
		return loc;
	}
}
