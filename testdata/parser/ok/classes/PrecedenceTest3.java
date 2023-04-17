int main() {
	C x;
        x = new C().m().m().m();
		return 0;
}

class C {
    C m() {
        return new C();
    }
}
