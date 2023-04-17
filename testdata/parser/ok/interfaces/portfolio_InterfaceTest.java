// Tests whether the parser accepts valid class and interface declarations

int main() {
        return 0;
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
