#include <iostream>
#include <fstream>
#include <sstream> 
#include <vector> 
#include <stack>
#include <queue>  
#include <map>
#include <set>
using namespace std; 

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
	int area = 0; 
	/*for each letter in the map, it checks for neighbors and counts the countries by using dfs*/
	for(int i = 0; i < row; i++) {
		for(int j = 0; j < col; j++) {
			visit[i][j] = 1; 
			char cur = map[i][j]; 
			
			pair<int,int> loc(i,j); 
			stack.push(loc); 
			int size = 1; 

			while(!stack.empty()) {
				pair<int,int> popped = stack.top(); 
				stack.pop(); 
				//right neighbor 
				if(popped.first+1 < row && map[popped.first+1][popped.second] == cur && visit[popped.first+1][popped.second] == 0) {
					visit[popped.first+1][popped.second] = 1; 
					size++;
					pair<int,int> neighbor(popped.first+1,popped.second); 
					stack.push(neighbor); 
				}
				//left neighbor 
				if(popped.first > 0 && map[popped.first-1][popped.second] == cur && visit[popped.first-1][popped.second] == 0) {
					visit[popped.first-1][popped.second] = 1; 
					size++;
					pair<int,int> neighbor(popped.first-1,popped.second); 
					stack.push(neighbor); 
				}
				//up neighbor 
				if(popped.second+1 < col && map[popped.first][popped.second+1] == cur && visit[popped.first][popped.second+1] == 0) {
					visit[popped.first][popped.second+1] = 1;
					size++; 
					pair<int,int> neighbor(popped.first,popped.second+1); 
					stack.push(neighbor); 
				}
				//down neighbor 
				if(popped.second > 0 && map[popped.first][popped.second-1] == cur && visit[popped.first][popped.second-1] == 0) {
					visit[popped.first][popped.second-1] = 1;
					size++; 
					pair<int,int> neighbor(popped.first,popped.second-1); 
					stack.push(neighbor); 
				}
			}
			if(size > area) {
				area = size; 
			}
		}
	}
	cout << area << endl; 
	for(int i = 0; i < row; i++) {
		delete[] map[i]; 
		delete[] visit[i]; 
	}
	delete[] map; 
	delete[] visit; 
}