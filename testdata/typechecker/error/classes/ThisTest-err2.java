int main() {
            int x;
		return 0;
}

class A {
    int m()
    {
        B y;
        y = this; // TE
        return 0;
    }

}

class B {}
