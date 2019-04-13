#ifndef PAGE_H
#define PAGE_H
#include <string>
using std::string;
#include<vector>
using std::vector;
class Page { 
public:
  Page(int i,const string &u);
  int getID() const { return id; }
  string getURL() const { return url;}
  double getRank() const { return rank; }
  void addLink(int id);
  void setRank(double r) { rank = r;}
  vector<int> &getLinks() { return links; };
private:
  int id;
  string url;
  double rank;
  vector<int> links;
};  
#endif
