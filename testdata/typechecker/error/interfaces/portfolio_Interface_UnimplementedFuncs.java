// Tests if the analysis phase can detect that a class has not implemented all methods of its ONE interface

int main() {
    return 0;
}

interface Test {
    int a(int op);

    boolean isOk(int yes);
}

class TestA implements Test {
    int a(int op) {
        return op;
    }
}
