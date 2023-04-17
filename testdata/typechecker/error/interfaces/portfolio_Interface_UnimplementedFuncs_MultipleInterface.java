// Tests if the analysis phase can detect that a class has not implemented all methods of its MULTIPLE interfaces

int main() {
    return 0;
}

interface Test {
    int a(int op);

    boolean isOk(int yes);
}

interface Test2 {
    boolean notImplemented();
}

class TestA implements Test, Test2 {
    int a(int op) {

    }
    boolean isOk(int yes) {

    }
}
