
#ifndef CIRCULAR_LIST_INT_H
#define CIRCULAR_LIST_INT_H

// ----------------------------------------
// CS104 HW2 Problem 2 skeleton header
// ----------------------------------------

#include <string>

// class to hold a circular list of integers.

// STUDENTS: you may not modify this header except by adding private member 
// variables and functions at the point marked below.
class CircularListInt
{
	// holds data about one item in the list.
	// a circular chain of these constitutes the list.
	struct Item
	{
		int value;

		// links to other items in the circular list.
		Item * next = nullptr;
		Item * prev = nullptr;

		// default no=argument constructor
		Item() = default;

		// default copy constructor
		Item(Item const & other) = default;

		// simple constructor that sets value
		Item(int itemValue): value(itemValue) {}
	};

	// ------------------------------------------

	// STUDENTS: add additional private members here

	// Finds the pointer to an item at the given index.
	// Handles wrapping the index around if it is ?= the size of the list.
	// Assumes that the size of the list is not 0.
	Item * findItem(size_t index) const;

	// ------------------------------------------

	// number of items in the list
	size_t count = 0;

	// pointer to current head of list (index 0)
	Item * head = nullptr;


public:

	// standard no-argument constructor
	CircularListInt();

	// no copy constructor. You guys haven't learned that yet, don't implement this!
	CircularListInt(CircularListInt const & other) = delete;
	
	// no assignment operator
	void operator==(CircularListInt const & other) = delete;

	// Destructor. Should delete all data allocated by the list. 
	~CircularListInt();

	//return the tail element's value; 
	int returnTail() const; 

	// Gets item at an index.
	// If an index is passed that is larger then the number of items in the list, it should "wrap around" back to the first element.
	// If there are no elements in the list, returns 0.
	int get(size_t index) const;



	// get length of list.
	size_t size() const;

	// returns true iff the list is empty.
	bool empty() const;

	//deletes tail 
	void popTail(); 

	// Inserts (a copy of) the given item at the end of list.
	void push_back(int value);

	// Sets the item at the given index to have the given value.
	// If an index is passed that is >= the number of items in the list, it should "wrap around" back to the first element.
	void set(size_t index, int value);

	// Removes the item at the given index from the list.
	// List elements after the removed element are pulled forward, so their indicies decrease by one.
	// If an index is passed that is larger then the number of items in the list, it should "wrap around" back to the first element.
	void remove(size_t index);


};

#endif
