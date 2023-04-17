// Tests whether the parser rejects field declarations in interfaces

int main() {
        return 0;
}

interface Test {
    int a;
}

interface Test2 {

}

class TestA implements Test, Test2 {

}
