CXX = g++
CPPFLAGS = -g -Wall -std=c++11  

all: .dirstamp parser 

parser: parser.cpp stack.o circLL.o 
	$(CXX) $(CPPFLAGS) $^ -o $@ 
stack_test: stack_test.cpp circLL.o stack.o
	$(CXX) $(CPPFLAGS) $^ -o $@ 
circLL.o: circular_list_int.cpp circular_list_int.h
	$(CXX) $(CPPFLAGS) -c $< -o $@ 
stack.o: stackint.cpp stackint.h circular_list_int.h
	$(CXX) $(CPPFLAGS) -c $< -o $@ 

.PHONY: clean
clean:
	rm -rf stack_test circLL.o stack.o parser converted.txt

.dirstamp:
	touch .dirstamp 