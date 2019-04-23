#include "circular_list_int.h"
#include "stackint.h"

StackInt::StackInt() { 

}

StackInt::~StackInt() { 

}

bool StackInt::empty() const { 
	return list.empty(); 
}
void StackInt::push(const int& value) { 
	list.push_back(value); 
}
//if user tries to call top() when list is empty it will return a garbage value 
int StackInt::top() const { 
	return list.returnTail(); 
}
void StackInt::pop() { 
	list.popTail();  
}
