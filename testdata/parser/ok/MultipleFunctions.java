boolean testEq(int a, int b) {
    return a == b;
}

int foo() {
    return 42;
}

int bar(int val) {
    return foo() + val;
}

int main() {
    if (testEq(foo(), bar(1))) {
        return 1;
    }
    else return 0;
}