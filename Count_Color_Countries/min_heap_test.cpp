#include "MinHeap.h"
#include <iostream>


using namespace std; 

int main() {
	MinHeap<char> heap(3);
	heap.add('A',5);
	heap.add('B', 1); 
	heap.add('c', -1); 
	heap.add('e', -5); 
	heap.add('d', 10); 
	heap.remove();
	char buf = heap.peek(); 
	cout << buf << endl; 
	heap.remove(); 
	heap.remove(); 
	heap.remove(); 
	heap.remove(); 
	try {
		heap.peek(); 
	} catch(exception& ex) {
		cout << ex.what() << endl;
	}

	bool test = heap.isEmpty(); 

	cout << test << endl;

	 


} 
