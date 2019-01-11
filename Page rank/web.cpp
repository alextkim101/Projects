#include "page.h"
#include "web.h"
#include <cstring>
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
//#include <map>
#include <cstdlib>
using namespace std;
Web::Web() { 

}

Web::~Web() {

}

bool Web::read_graph(const char *filename) { 

	int pagenum; 
	int id; 
	string url; 
	double rank; 
	string buff; 
	ifstream graph(filename); 
	stringstream ss; 
	if(graph.fail()) { //check if we can open file 
		return false;
	} else { 
		getline(graph, buff); 
		ss << buff; 
		ss >> pagenum; 
		if(ss.fail()) {//check if file is formatted propely
			return false;
		}

		num_pg = pagenum;  
		cout << num_pg << endl; 
		ss.clear();
		for(int i = 0; i < pagenum; i++) {
			getline(graph, buff); //reads from the ,txt file 
			ss << buff; 
			ss >> id; 
			ss.clear();
			getline(graph, buff); 
			ss << buff; 
			ss >> url; 
			ss.clear();

			Page page(id, url); //creates new page with read elements 

			getline(graph, buff); 
			ss << buff; 
			ss >> rank;
			page.setRank(double(rank));  
			ss.clear();
			getline(graph, buff); 
			ss << buff;

			int num_links;  
			while(ss >> num_links) { //while true, reads links into vector 
				page.addLink(num_links); 
			}
			ss.clear(); 
			pages.push_back(page);  

			} 
		return true; 
	}
} 
bool Web::write_graph(const char *filename) {

	ofstream output(filename); 
	if(output.fail()) { 
		return false; 
	} else { 
		output << num_pg << endl; 
		for(int i = 0; i < num_pg; i++) { //formats data 
			output << pages[i].getID() << endl;
			output << "\t" << pages[i].getURL() << endl; 
			output << "\t" << pages[i].getRank() << endl; 
			output << "\t";
			for(int j = 0; j < pages[i].getLinks().size(); j++) { 
				output << pages[i].getLinks()[j] << " ";
			} 
			output << endl;
		}
	}
	return true; 
}

void Web::calculate_rank(int S,int N) {

	int* walker = new int[N];  

	//divides walkers equal among pages
	int numberOfWalkersPerPage = N / num_pg;  

	//assigns walkers pages 
	for(int i = 0; i < num_pg; i++) { 
		for(int j = 0; j < numberOfWalkersPerPage; j++) {
			walker[numberOfWalkersPerPage * i + j] = i;
		}
	}
	//each walker moves to a random page from the list of links on the page 
	for(int j = 0; j < S; j++) { 
		for(int i = 0; i < N; i++) { 
			vector<int> glinks = pages[walker[i]].getLinks();

			walker[i] = glinks[rand() % glinks.size()]; 

		}
	}


	double* proprotion = new double[num_pg]; 
	//init values as zero 
	for(int i = 0; i < num_pg; i++) { 
		proprotion[i] = 0; 
	}
	//for each walker, keeps track of how many walkers on the pages 
	for(int i = 0; i < N; i++) { 
		proprotion[walker[i]]++;
	}
	//sets rank 
	for(int i = 0; i < num_pg; i++) { 
		pages[i].setRank(proprotion[i]/(double)N); 
		//cout << pages[i].getRank() << " "; 
	}

	//deletes dynamically allocated memory 
	delete[] walker; 
	delete[] proprotion; 
}




