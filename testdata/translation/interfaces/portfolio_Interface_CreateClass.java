// Tests the handling of interface objects in the translator

int main() {
    // declare interface
    Test v;
    // create class that implements this interface
    v = new TestA();
    // execute function
    v.a(100);
    return 0;
}

interface Test {
    int a(int op);
}

interface Test2 {
    int b(int op);
}

class TestA implements Test {
    int a(int op) {
        printInt(op + 100);
        return 0;
    }

    int b(int op) {
        printInt(op);
        return 0;
    }
}