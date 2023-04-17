int main() {
        printInt(new Fac().ComputeFac(10));
    	return 0;
}

class Fac {
    private int ComputeFac(int num){  //<------------ syntax
        int num_aux ;
        if (num < 1)
            num_aux = 1 ;
        else
            num_aux = num * (this.ComputeFac(num-1)) ;
        return num_aux ;
    }
}
