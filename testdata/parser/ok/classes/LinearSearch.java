int main() {
	printInt(new LS().Start(10));
    	return 0;
}


// This class contains an array of integers and
// methods to initialize, print and search the array
// using Linear Search
class LS {
    int[] number ;
    int size ;
    
    // Invoke methods to initialize, print and search
    // for elements on the array
    int Start(int sz){
	int aux01 ;
	int aux02 ;

	aux01 = this.Init(sz);
	aux02 = this.Print();
	printInt(9999);
	printInt(this.Search(8));
	printInt(this.Search(12)) ;
	printInt(this.Search(17)) ;
	printInt(this.Search(50)) ;
	return 55 ;
    }

    // Print array of integers
    int Print(){
	int j ;

	j = 1 ;
	while (j < (size)) {
	    printInt(number[j]);
	    j = j + 1 ;
	}
	return 0 ;
    }

    // Search for a specific value (num) using
    // linear search
    int Search(int num){
	int j ;
	boolean ls01 ;
	int ifound ;
	int aux01 ;
	int aux02 ;
	int nt ;

	j = 1 ;
	ls01 = false ;
	ifound = 0 ;
	
	//printInt(num);
	while (j < (size)) {
	    aux01 = number[j] ;
	    aux02 = num + 1 ;
	    if (aux01 < num) nt = 0 ;
	    else if (!(aux01 < aux02)) nt = 0 ;
	    else {
		ls01 = true ;
		ifound = 1 ;
		j = size ;
	    }
	    j = j + 1 ;
	}

	return ifound ;
    }


    
    // initialize array of integers with some
    // some sequence
    int Init(int sz){
	int j ;
	int k ;
	int aux01 ;
	int aux02 ;

	size = sz ;
	number = new int[sz] ;
	
	j = 1 ;
	k = size + 1 ;
	while (j < (size)) {
	    aux01 = 2 * j ;
	    aux02 = k - 3 ;
	    number[j] = aux01 + aux02 ;
	    j = j + 1 ;
	    k = k - 1 ;
	}
	return 0 ;	
    }

}