#include "stackint.h"
#include "circular_list_int.h"
#include <fstream> 
#include <iostream>
#include <sstream> 

int main(int argc, char* argv[]) {

	const int OPEN_PAREN = -1;
	const int CLOSE_PAREN = -11; 
	const int MULTIPLY = -2; 
	const int ADD = -3; 
	const int L_SHIFT = -4; 
	const int R_SHIFT = -5; 
	
	StackInt stack; 
	std::ifstream exps(argv[1]); 
	std::string buff; 
	std::ofstream conv("converted.txt");
	std::stringstream ss; 

//this converts the expression translates with each operator as different neg values
//and prints them out into a file called "converted"
	while(getline(exps, buff)) {  

		ss << buff; 
		std::string emptyCheck = ""; 
		ss >> emptyCheck; //since stringstream 'eats' the spaces, this check if buff has any actual content
		ss.clear(); 
		
		for(unsigned int i = 0; i < buff.length(); i++) { 
			if(buff.at(i) == '(') { 
				conv << "-1" << " "; 
			} else if(buff.at(i) == ')') { 
				conv << "-11" << " "; 
			} else if(buff.at(i) == '+') { 
				conv << "-3" << " "; 
			} else if(buff.at(i) == '*') { 
				conv << "-2" << " "; 
			} else if(buff.at(i) == '<') { 
				conv << "-4" << " "; 
			} else if(buff.at(i) == '>') { 
				conv << "-5" << " "; 
			} else if(buff.at(i) == ' '){
				//if the char is ' ' then do nothing 
			} else if(buff.at(i) == '	') {

			} else if((buff.at(i) != ')' && buff.at(i) != '(' && buff.at(i) != '+' && buff.at(i) != '*' && buff.at(i) != '<' && buff.at(i) != '>') 
				&& (buff.at(i) < 48 || buff.at(i) > 57)) {
				conv << "-999" << " "; 
				//-999 is a garbage value that will make the expression evalute to Malformed 
				//48 is '0' and 57 is '9'
			} else if(((buff.at(i)-'0') <= 9 || (buff.at(i) - '0') >= 0) && i == (buff.length()-1)){
				conv << buff.at(i) << " "; 
			} else if((buff.at(i+1)-'0') > 9 || (buff.at(i+1) - '0') < 0) { 
				conv << buff.at(i) << " "; 
			} else if((buff.at(i) - '0') >= 0 && (buff.at(i)-'0' <= 9)){ 
				conv << buff.at(i); 
			} else { 
				conv << "-999" << " "; 
			}
		}
		// this kills all the empty lines. 
		if(buff.length() > 0 && emptyCheck.length() > 0)conv << std::endl; 

	}

	std::stringstream ss2; 
	std::string temp; 
	std::ifstream converted("converted.txt"); 

	while(getline(converted, temp)) { 

		bool malform = false; 
		ss2 << temp;  
		int value = 0;

		while(ss2 >> value) { 

			if(value != CLOSE_PAREN) { 
				stack.push(value); 
			} else if(value == CLOSE_PAREN) { 

				int consOper = 0;//will be use to check if operator is consistent within a set of paren
				int iter = 0; //counts number of evaluation within a set of parentheses
				int operCount = 0; //keeps track of + and * operators

				while(stack.top() != OPEN_PAREN) {

					int num1 = stack.top();

					if(num1 < 0) { //checks if operand is negative
						malform = true; 
						break; 
					} 

					stack.pop(); 

					int oper = stack.top();
					
					if(oper >= 0) { //checks if operator is positivie 
						malform = true; 
						break; 
					//first iteration, we set the consoperator. 
					//if operators with a set of paren are not the same, then update malform flag as true; 
					} else if(iter >= 1 && oper != consOper && consOper != 0) { 
						malform = true; 
						break; 
					} 

					if(oper > -4 && oper < -1) {
						consOper = oper; //checks if operator type is constant for each expression inside parentheses 
						operCount++; 
					}

					stack.pop();  

					int result = 0;
					// if's the operator is NOT < or > then we need second operand
					if(oper != R_SHIFT && oper != L_SHIFT) {  

						int num2 = stack.top();

						if(num2 < 0) { 
							malform = true; 
							break; 
						} 
						stack.pop();
						//if the second operand has < or > then do this first; 
						while(stack.top() == R_SHIFT || stack.top() == L_SHIFT) { 
							int oper2 = stack.top(); 
							stack.pop(); 
							if(oper2 == R_SHIFT) { 
								num2 = num2/2; 
							} else if(oper2 == L_SHIFT) {
								num2 = num2*2; 
							}
						}

						if(oper == ADD) { 
							result = num1 + num2;
						} else if(oper == MULTIPLY) { 
							result = num1*num2; 
						} 
					}

				 	if(oper == L_SHIFT) { 
						result = num1*2; 
					} else if(oper == R_SHIFT) { 
						result = num1/2; 
					} else if(oper < -5){ 
						malform = true; 
					}

					if(stack.top() == OPEN_PAREN) { 
						//when you encounter the open parentheses, you check if there was at least one + or * operator
						if(operCount == 0) {
							malform = true; 
							break;
						} else { 
							stack.pop(); 
							stack.push(result); 
							break;
						} 
					}
					stack.push(result);
					++iter; 
				}
			}
		}

		ss2.clear(); //clears stringstream for nextline 

		bool check = false; //simply a sentinel to prevent printing malfored twice. 

		//if there's nothing in the stack then something went wrong 
		if(stack.empty()) { 
			std::cout << "Malformed" << std::endl; 
			check = true; 
		}

		//pops the final result. assuming the expression correctly formatted, the only thing in the
		//stack should be the result of the expression  
		int final = stack.top(); 
		stack.pop(); 

		//checks if the only things outside the outermost parentheses are shift operators 
		if(!stack.empty() && (stack.top() == R_SHIFT || stack.top() == L_SHIFT)) { 
			while(stack.top() == R_SHIFT || stack.top() == L_SHIFT) { 
				int oper2 = stack.top(); 
				stack.pop(); 
				if(oper2 == R_SHIFT) { 
					final = final/2; 
				} else if(oper2 == L_SHIFT) {
					final = final*2; 
				}
			}
		}
		//if the stack is empty and malform flag is false and final value is greater 1 (safe guard) 
		//then we can print out the solution. 
		if(!malform  && stack.empty() && final > -1) {
			std::cout << final << std::endl; 
		} else if(!check) {
			std::cout << "Malformed" << std::endl; 
		}
		//empties the stack for next line of expression 
		while(!stack.empty()) { 
			stack.pop(); 
		}

	}
	return 0; 
}

