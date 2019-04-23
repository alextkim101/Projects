#include <vector> 
#include <exception> 
#include <stdexcept> 

template <class T>
  class MinHeap {
    public:
      MinHeap (int d);
       /* Constructor that builds a d-ary Min Heap
          This should work for any d >= 2,
          but doesn't have to do anything for smaller d.*/

      ~MinHeap ();

      void add (T item, int priority);
         /* adds the item to the heap, with the given priority. */

      const T & peek () const;
         /* returns the element with smallest priority.  
            Break ties however you wish.  
            Throws an exception if the heap is empty. */

      void remove ();
         /* removes the element with smallest priority.
            Break ties however you wish.
            Throws an exception if the heap is empty. */

      bool isEmpty ();
         /* returns true iff there are no elements on the heap. */
    private:
      // whatever you need to naturally store things.
      // You may also add helper functions here.
      void trickleDown(int pos);
      void bubbleUp(int pos);
      void swap(int l, int r); 

      int _d; 
      std::vector<std::pair<T,int>> heap; //pair consisting of class T and its priority 

      struct its_empty : std::exception {
        const char* what() const noexcept {return "Exception: The heap is empty!";}
      };
  };

template <class T> 
MinHeap<T>::MinHeap (int d) {
    if(d < 2) {
      //do nothing 
    } else {
      _d = d; 
    }
}
  
template <class T> 
MinHeap<T>::~MinHeap () {

}

template <class T> 
void MinHeap<T>::add (T item, int priority) {
    std::pair<T,int> _new(item,priority); 
    heap.push_back(_new); 
    bubbleUp(heap.size()-1); 
}

/* returns the element with smallest priority.  
Break ties however you wish.  
Throws an exception if the heap is empty. */
template <class T> 
const T& MinHeap<T>::peek () const {

  if(heap.empty()) {
    its_empty e;
    throw e; 
  } else {
    return heap[0].first; 
  }
}

template <class T> 
void MinHeap<T>::remove () {
  if(heap.empty()) {
    its_empty e; 
    throw e; 
  } else {
    swap(0,heap.size()-1); 
    heap.pop_back(); 
    trickleDown(0);
  } 
}

template <class T>
bool MinHeap<T>::isEmpty () {
  if(heap.empty()) {
    return true; 
  } else {
    return false; 
  }
}
template <class T>
void MinHeap<T>::trickleDown(int pos) {
  unsigned int child = _d*pos+1; 
  if(child < heap.size()) {
    for(unsigned int i = child; i < child+_d; i++) {//find the smallest child; 
      if(i < heap.size() && heap[child].second > heap[i].second) {
        child = i; 
      }
    }
    if(heap[child].second < heap[pos].second) {
      swap(child,pos); 
      trickleDown(child); 
    }
  }
}
template <class T> 
void MinHeap<T>::bubbleUp(int pos) {
  int parent = (pos-1)/_d; 
  if(pos > 0 && heap[pos].second < heap[parent].second) {
    swap(pos,parent); 
    bubbleUp(parent); 
  }

}
template <class T> 
void MinHeap<T>::swap(int r, int l) {
  std::pair<T,int> copy = heap[r]; 
  heap[r] = heap[l]; 
  heap[l] = copy; 
}

