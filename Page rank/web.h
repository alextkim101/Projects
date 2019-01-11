#ifndef WEB_H
#define WEB_H
#include "page.h"
#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
//#include <map>
#include <cstdlib>
using namespace std;

class Web { 

public:
    Web();
    ~Web();
    bool read_graph(const char *filename);
    bool write_graph(const char *filename);
    void calculate_rank(int S,int N);
    void print_pages()  {
	for(int i=0;i<pages.size() ;i ++) { 
		cout << pages[i].getID() << " -> " ;
                for(int j=0;j<pages[i].getLinks().size();j++) { 
			cout << pages[i].getLinks()[j] << " ";
		}
		cout << endl;

        }
    }
private:    
//  map<int,int> walkers; 
//  vector<int> walkers;
  vector<Page> pages;
  int num_pg; 
};  
#endif
