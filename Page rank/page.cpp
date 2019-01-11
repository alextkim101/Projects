#include <string>
#include "page.h"
#include<vector>
using std::string;
using std::vector;


Page::Page(int i, const string &u) { 
	id = i; 
	url = u; 
}
void Page::addLink(int ID) { 
	links.push_back(ID); 
}

