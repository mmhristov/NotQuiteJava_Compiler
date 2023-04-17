int main() {
        Blub b;
        int a;
        bolean c;
        b = new Blub();
        c = b.blah();
        a = b.bleh(4);
        b = b.bluh();
    	return 0;
}

class Blub {
    boolean blah(){return false;}
    int bleh(int a){return a;}
    Blub bleh(){return new Blub();}
}
