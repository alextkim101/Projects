#include <iostream>
#include "circular_list_int.h"
#include "stackint.h"
using namespace std; 


int main() {
	StackInt stack; 
	stack.push(1); 
	stack.push(2); 
	stack.push(3); 
	stack.pop();
	stack.pop(); 
	stack.pop(); 
	//int top = stack.top(); 

	cout << stack.empty()<< " this should be 1" << endl; 

} 