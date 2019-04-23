#ifndef STACKINT_H
#define STACKINT_H
#include "circular_list_int.h"

class StackInt {
 public:
  StackInt();
  ~StackInt();

  /**
   * Returns true if the stack is empty, false otherwise
   */
  bool empty() const;

  /**
   * Pushes a new value, val, onto the top of the stack
   */
  void push(const int& val);

  /**
   * Returns the top value on the stack
   */
  int  top() const;

  /**
   * Removes the top element on the stack
   */
  void pop();

 private:
  /** 
   * Single data member of the Stack.
   * We use composition to implement this Stack 
   */
  CircularListInt list;
};
#endif
