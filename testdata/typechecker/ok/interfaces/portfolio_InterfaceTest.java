// Tests if the analysis phase accepts a valid declaration of a class, which implements interfaces

int main() {
        return 0;
}

interface Test {
    int a(int op);

    boolean isOk(int yes);
}

interface Test2 {
    int b();
}

class TestA implements Test, Test2 {
    int a(int op) {
        return 1;
    }
    boolean isOk(int yes) {
        return false;
    }
    int b() {
        return 0;
    }
}
