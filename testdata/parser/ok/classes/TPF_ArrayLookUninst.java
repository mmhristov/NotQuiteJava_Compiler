int main() {
		int b;
		arrayCarrier a;
		a = new arrayCarrier();
		b = a.GetP()[0];
		return 0;
}

class arrayCarrier {
	int[] p;

	int[] GetP() {
		return p;
	}
}
