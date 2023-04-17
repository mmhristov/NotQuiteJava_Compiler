int main() {
		printInt(new C().value());
		return 0;
}

class C {

	int v;

	int value() {
		v = 555;
		return v;
	}

}