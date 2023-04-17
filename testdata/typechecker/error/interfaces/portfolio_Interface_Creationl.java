// Tests if the analysis phase can detect the error of instantiating an interface

int main() {
        Test v;
        v = new Test();
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
