// Tests the translation of a class witn a method
// Additionally, field access without using the "this" keyword is tested too

int main() {
        SimpleMethods c;
        c = new SimpleMethods();
        c.isSimple = false;
        c.simpleMethod(c.isSimple);
        return 0;
}

class SimpleMethods {
    boolean isSimple;
    int numnum;
    int simpleMethod(boolean argument) {
        if (argument) {
            printInt(1);
        } else {
            numnum = numnum - 2;
            printInt(numnum);
        }
        return 0;
    }
}