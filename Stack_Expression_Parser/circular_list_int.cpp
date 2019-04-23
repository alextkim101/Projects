#include "circular_list_int.h"

//[NOTE] loc is short for location

CircularListInt::CircularListInt() { 

}
//as long as there are elements, call remove(). 
CircularListInt::~CircularListInt() {  
	size_t count_copy = count; 
	size_t curr = 0; 
	while(curr < count_copy) { 
		remove(curr); 
		++curr; 
	}
}

CircularListInt::Item * CircularListInt::findItem(size_t index) const { 
	if(count == 0) return nullptr; 
	size_t new_index = index%count; 
	size_t curr = 0; 
	Item* loc = head; 
	while(curr < new_index) { //traverse through the list until index is reached 
		loc = loc->next; 
		++curr; 
	} 
	return loc; 
}


int CircularListInt::get(size_t index) const { 
	if(count == 0 ) return 0; 
	Item* loc = findItem(index); 
	return loc->value; 
}

int CircularListInt::returnTail() const { 
	if(count == 0) return 19834518; 
	return head->prev->value; 
}

size_t CircularListInt::size() const { 
	return count; 
}

bool CircularListInt::empty() const { 
	if(count == 0) { 
		return true; 
	} else { 
		return false; 
	}
}

void CircularListInt::push_back(int value) { 
	Item* new_item = new Item(value);
	//edge case for adding the first element. Makes the item* point to itself. 
	if(head == nullptr) { 
		new_item->prev = new_item; 
		new_item->next = new_item; 
		head = new_item; 
	} else { 
		//adding item at the end of the list which means at head->previous
		//because it's circularly linked. 
		head->prev->next = new_item; 
		new_item->next = head; 
		new_item->prev = head->prev; 
		head->prev = new_item; 
	}
	++count; //update # of elements 
}

void CircularListInt::set(size_t index, int value) {
	//if there are no elements and user tries to call 
	//set(...) then do nothing and return.  
	if(count == 0) { 
		return; 
	} 
	Item* loc = findItem(index); 
	loc->value = value; 
}

void CircularListInt::remove(size_t index) { 
	size_t new_index = index%count; 
	//edge case for when removing the only element 

	if(count == 1) { 
		delete head; 
		 head = nullptr; 
		 --count; 
	} else {  
		Item* loc = findItem(index); 
		loc->prev->next = loc->next; 
		loc->next->prev = loc->prev; 
		if(new_index == 0) { //need to update head if head is removed. 
			head = loc->next; 	
		}
		delete loc; 
		--count; //update # of elements 
	}
}

void CircularListInt::popTail() { 
	if(count == 0) { 
		return; 
	}
	if(count == 1) { 
		delete head; 
		head = nullptr; 
		--count; 
	} else { 
		Item* copy = head->prev; 
		head->prev->prev->next = head; 
		head->prev = head->prev->prev; 
		delete copy; 
		--count; 
	}
}
