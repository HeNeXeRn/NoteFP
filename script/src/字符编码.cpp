#include "fstream.h"
#include "function.h"
#include<iostream>
using namespace std;

int char_num(char a)
{
    if (a == '*')
        return 10;
    if (a >= '0' && a <= '9')
        return a - '0';
    if (a >= 'a' && a <= 'z')
        return a - 'a' + 11;
    if (a >= 'A' && a <= 'Z')
        return a - 'A' + 11;
        return 0;
}

int main()
{
    string temp;
    int cnt=0;
    while (fin[0] >> temp)
    {
        out<<"7'd"<<cnt++<<":\nbegin\n";
        for (int i=0;i<temp.size();++i){
            out<<"Seg"<<i+1<<"<=6'b";
            cout<<char_num(temp[i])<<" ";
            out << fun::toBinaryString(6, char_num(temp[i]));
            out<<';';
        }
        out << "\nend\n";
    }
}