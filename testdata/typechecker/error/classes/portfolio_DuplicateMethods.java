// Tests if the analysis phase can detect duplicate method names in a class

int main() {
    return 0;
}

class A {
    int a() {
        return 1;
    }
}

class B extends A {

    int b() {
        return 0;
    }

    boolean b() {
        return true;
    }
}