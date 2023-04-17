// Tests the transaltor's ability to handle interface polymorphism

int main() {
    int res;
    A a;

    a = new C();
    res = a.num();
    printInt(res);

    a = new D();
    res = a.num();
    printInt(res);

    return 0;
}

interface B {
    int b();
}

interface A {
    int num();
}

class C implements A {

    int b() {
        return 69;
    }
    int num() {
        return 1;
    }
}

class D implements A {
    int num() {
        return 2;
    }
}
