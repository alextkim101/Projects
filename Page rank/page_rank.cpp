#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;
#include "web.h"
#include "page.h"

int main(int argc,char *argv[] ) { 

  if(argc < 5 ) { 
    cerr << "Usage: pagerank <graph_input> <graph_output> <Number_of_walker> "
    << "<Number_of_Simulation>" << endl;
    return 1;
  }
//int seed = 1508998908;//time(NULL);
int seed = time(NULL);
  srand(seed);
//srand(100);
  int N = atoi(argv[3]); //Number of walkers
  int S = atoi(argv[4]) ; //Number of Simulation iteration
  Web web;

  //web.print_pages(); 

  if(!web.read_graph( argv[1] )){
   cout << "Cannot read graph" << endl; return 1;
  }
  web.calculate_rank(S,N);
  if(!web.write_graph(argv[2])){ 
    cout <<"Cannot write graph " << endl; return 1;
  }
 return 0; 
}
