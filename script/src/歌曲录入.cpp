#include"fstream.h"
#include"function.h"
using namespace std;

int main(){
    string input;
    int cnt=0;
    while(in>>input){
        for(auto iter=input.begin();iter!=input.end();){
            int temp=0;
            if(*iter!='0')
            if(iter+1!=input.end() && *(iter+1)=='+'){
                if(iter+2!=input.end() && *(iter+2)=='+'){
                    temp=21+*iter-'0';
                    iter+=3;
                }else{
                    temp=14+*iter-'0';
                    iter+=2;
                }
            }else{
                if(iter+1!=input.end() && *(iter+1)=='-'){
                    temp=*iter-'0';
                    iter+=2;
                }else{
                    temp=7+*iter-'0';
                    iter++;
                }
            }
            else *iter++;
            out<<cnt++<<":note=5'b"<<fun::toBinaryString(5, temp)<<";\n";
        }
    }
    out<<"\n\n"<<cnt;
}