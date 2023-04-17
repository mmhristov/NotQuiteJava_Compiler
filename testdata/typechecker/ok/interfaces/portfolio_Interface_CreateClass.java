// Tests if the analysis phase accepts a valid creation of a class, implementing multiple interfaces
// one of which has no declared methods

int main() {
    Test v;
    v = new TestA();
    return v.a(1);
}

interface Test {
    int a(int op);

    boolean isOk(int yes);
}

interface Test2 {

}

class TestA implements Test, Test2 {
    int a(int op) {

    }
    boolean isOk(int yes) {

    }
}