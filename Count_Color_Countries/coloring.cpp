#include <iostream>
#include <fstream>
#include <sstream> 
#include <vector> 
#include <stack>
#include <map>
#include <set>
using namespace std; 

bool threat(map<char,set<char>> neighbors, map<char,int>& coloring, char l, int color); 
bool color(map<char,set<char>> neighbors, map<char,int>& coloring, char l); 
void printSolution(map<char,int> coloring); 

int main(int argc, char* argv[]) {
	ifstream input_file(argv[1]); 
	stringstream ss; 
	string buf; 
	getline(input_file, buf); 
	ss << buf; 
	int count; 
	int row; 
	int col; 
	ss >> count; 
	ss >> row; 
	ss >> col; 

	ss.clear(); 
	map<char,int> letters; 

	map<char,set<char>> neighbors; 

	map<char,int> coloring; 

	stack<pair<int,int>> stack; 
	char** map = new char*[row]; 
	int** visit = new int*[row]; 

	for(int i = 0; i < row; i++) {
		map[i] = new char[col]; 
		visit[i] = new int[col]; 
	}
	for(int i = 0; i < row; i ++) {
		getline(input_file, buf); 
		ss << buf; 
		for(int j = 0; j < col; j++) {
			map[i][j] = buf.at(j); 
			visit[i][j] = 0; 
		}
	}	

	for(int i = 0; i < row; i++) {
		for(int j = 0; j < col; j++) {
			visit[i][j] = 1; 
			char cur = map[i][j]; 
			if(letters.find(map[i][j]) == letters.end()) {
				letters.emplace(cur,1); 
				set<char> list; 
				neighbors.emplace(cur,list); 
				coloring.emplace(cur, 0); 
			} 
			pair<int,int> loc(i,j); 
			stack.push(loc); 
			/* for each left, right, down, up neighbor, it checks for countries and if the neighbor 
			is a different letter it adds to the set of neighbors*/
			while(!stack.empty()) {
				pair<int,int> popped = stack.top(); 
				stack.pop(); 
				if(popped.first+1 < row && map[popped.first+1][popped.second] == cur && visit[popped.first+1][popped.second] == 0) {
					visit[popped.first+1][popped.second] = 1; 
					pair<int,int> neighbor(popped.first+1,popped.second); 
					stack.push(neighbor); 
				} else if(popped.first+1 < row && map[popped.first+1][popped.second] != cur){
					if(neighbors.find(cur)->second.find(map[popped.first+1][popped.second]) == neighbors.find(cur)->second.end()) {
						neighbors.find(cur)->second.insert(map[popped.first+1][popped.second]); 
					}
				}
				if(popped.first > 0 && map[popped.first-1][popped.second] == cur && visit[popped.first-1][popped.second] == 0) {
					visit[popped.first-1][popped.second] = 1; 
					pair<int,int> neighbor(popped.first-1,popped.second); 
					stack.push(neighbor); 
				}else if(popped.first > 0 && map[popped.first-1][popped.second] != cur ){
					if(neighbors.find(cur)->second.find(map[popped.first-1][popped.second]) == neighbors.find(cur)->second.end()) {
						neighbors.find(cur)->second.insert(map[popped.first-1][popped.second]); 
					}
				}
				if(popped.second+1 < col && map[popped.first][popped.second+1] == cur && visit[popped.first][popped.second+1] == 0) {
					visit[popped.first][popped.second+1] = 1;
					pair<int,int> neighbor(popped.first,popped.second+1); 
					stack.push(neighbor); 
				}else if(popped.second+1 < col && map[popped.first][popped.second+1] != cur){
					if(neighbors.find(cur)->second.find(map[popped.first][popped.second+1]) == neighbors.find(cur)->second.end()){
						neighbors.find(cur)->second.insert(map[popped.first][popped.second+1]); 
					}
				}
				if(popped.second > 0 && map[popped.first][popped.second-1] == cur && visit[popped.first][popped.second-1] == 0) {
					visit[popped.first][popped.second-1] = 1;
					pair<int,int> neighbor(popped.first,popped.second-1); 
					stack.push(neighbor); 
				}else if(popped.second > 0 && map[popped.first][popped.second-1] != cur){
					if(neighbors.find(cur)->second.find(map[popped.first][popped.second-1]) == neighbors.find(cur)->second.end()){
						neighbors.find(cur)->second.insert(map[popped.first][popped.second-1]); 
					}
				}
			}
		}
	}

	if(color(neighbors, coloring, 'A')) { //this will always be true but must be fit the return type  
		printSolution(coloring); 
	} 

	for(int i = 0; i < row; i++) {
		delete[] map[i]; 
		delete[] visit[i]; 
	}
	delete[] map; 
	delete[] visit; 
}
//check if the given color assignment is valid based on the neighbor list 
bool threat(map<char,set<char>> neighbors, map<char,int>& coloring, char l, int color) {
	set<char> neiber_list = neighbors.find(l)->second; 
	for(set<char>::iterator sit = neiber_list.begin(); sit != neiber_list.end(); sit++) {
		if(color == coloring.find(*sit)->second) {
			return true; 
		}
	}
	return false; 
}
bool color(map<char,set<char>> neighbors, map<char,int>& coloring, char l) {
	if(l == char(coloring.begin()->first + coloring.size())) {
		return true; 
	}
	for(int c = 1; c <= 4; c++) {
		if(threat(neighbors,coloring,l,c) == false) {
			coloring.find(l)->second = c; 
			//if get out of this conditional return true; 
			if(color(neighbors, coloring, char(l+1))) {
				return true; 
			}
			//this will never get reached unless an improper color assignment happens 
			coloring.find(l)->second = 0;  
		}
	}
	return false; 
}
void printSolution(map<char,int> coloring) {
	for(map<char,int>::iterator mit = coloring.begin(); mit != coloring.end(); mit++) {
		cout << mit->first << " " << mit->second << endl; 
	}
} 