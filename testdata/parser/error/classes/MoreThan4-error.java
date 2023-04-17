int main() {
        printInt(new MT4().Start(1,2,3,4,5,6));
    	return 0;
}

class MT4 {
    int Start(int p1, int p2, int p3 , int p4, int p5, int p6){
	int aux ;
        printInt(p1);
        printInt(p2);
        printInt(p3);
        printInt(p4);
        printInt(p5);
        printInt(p6);
		aux = this.Change(p6,p5,p4 p3,p2);//Syntax error
	return aux ;
    }

    int Change(int p1, int p2, int p3 , int p4, int p5, int p6){
        printInt(p1);
        printInt(p2);
        printInt(p3);
        printInt(p4);
        printInt(p5);
        printInt(p6);
	return 0 ;
    }
}