// Tests the translation of class fields

int main() {
    TTTest c;
    c = new TTTest();
    c.var1 = 1;
    c.var2 = c.var1 + 2;
    printInt(c.var2);
    return 0;
}

class TTTest {
    int var1;
    int var2;
}