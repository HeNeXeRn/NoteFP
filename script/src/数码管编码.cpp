#include"fstream.h"
#include<vector>
#include<string>
using namespace std;
int main(){
    vector<string>code;
    string input;
    while(in>>input){
        code.push_back(input);
    }
    for(int i=0;i<code.size();++i){
        out<<"6'd"<<i<<":data=8'b"<<code[i]<<";\n";
    }
}