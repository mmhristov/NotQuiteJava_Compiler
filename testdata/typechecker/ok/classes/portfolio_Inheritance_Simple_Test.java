int main() {
        Beel b;
        b = new Beel();
        return b.n();
}

class Aal {
    int a;

    boolean setA(int a) {
        this.a = a;
        return true;
    }

    boolean incrementTwice() {
        this.a = this.a + 2;
        return true;
    }

}

class Beel extends Aal {
    int b;

    boolean setB(int b) {
        this.b = b;
        return true;
    }

    int n() {
        this.setA(0);
        this.setB(3);
        this.incrementTwice();
        return this.a + this.b;
    }
}