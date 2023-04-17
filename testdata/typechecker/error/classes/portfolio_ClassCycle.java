// Tests if the analysis phase can detect inheritance cycles

int main() {
    return 0;
}

class A extends C{

}

class B extends A {

}

class C extends B {

}
