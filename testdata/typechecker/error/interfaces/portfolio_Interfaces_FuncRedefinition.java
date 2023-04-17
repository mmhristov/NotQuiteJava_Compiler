// Tests if the analysis phase can detect duplicate method names in an interface

int main() {
        return 0;
}

interface Testing {
    int a(int op);

    boolean isOk(int yes);

    int a(int x); // redeclaration of unique function name -> error
}

class A implements Testing {
    int a(int op) {

    }
    boolean isOk(int yes) {

    }
}