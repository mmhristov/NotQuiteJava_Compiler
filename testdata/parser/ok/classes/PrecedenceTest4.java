int main() {
	int x;
        x = new C().m().length;
		return 0;
}

class C {
    int[] m() {
        return new int[3];
    }
}
