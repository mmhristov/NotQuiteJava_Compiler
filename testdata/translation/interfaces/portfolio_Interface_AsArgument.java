// Tests the handling of interface arguments of functions

int main() {
        // declare class
        TestA cl;
        // create class
        cl = new TestA();

        // call func that accepts interface "Test" as argument
        printInt(testFunc(cl)); // currently causes nullpointer as translator can not find interface

        return 0;
}

int testFunc(Test iCl) {
    return iCl.a(5);
}

interface Test {
    int a(int op);
}

class TestA implements Test {
    int a(int op) {
        printInt(op + 100);
        return 0;
    }
}