int main() {
    	B b;
    	b.c.x = 1;
    	b.getC().x = 1;
    	b.c.x = b.c.m()[0]; 
		return 0;
}

class B{
	C c;
	C getC(){
		return c;
	}
}

class C {
	int x;
    int[] m() {
        return new int[3];
    }
}