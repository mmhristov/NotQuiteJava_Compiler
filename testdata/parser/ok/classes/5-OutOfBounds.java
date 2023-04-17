int main() {
	printInt(new A().run());
    	return 0;
}

class A {
     int[] a;

    int run() {
	a = new int[20];
	a[10] = 1;
	printInt(a[10]);
	return a[40];
    }
}
