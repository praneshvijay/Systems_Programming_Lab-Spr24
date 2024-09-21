#include<stdio.h>
#include<stdlib.h>
#include "settype.h"

numset setinit(int n){
    numset s = (numset)malloc((n+1)*sizeof(numset));
    s[0] = n;
    for(int i=1;i<=n;i++){
        s[i] = 0;
    }
    return s;
}

numset setrand(int n){
    numset s = (numset)malloc((n+1)*sizeof(numset));
    s[0] = n;
    for(int i=1;i<=n;i++){
        s[i] = rand()%2;
    }
    return s;
}

numset setrandsize(int n, int t){
    numset s = (numset)malloc((n+1)*sizeof(numset));
    s[0] = n;
    for(int i=1;i<=n;i++){
        s[i] = 0;
    }
    int i = 0;
    while(i<t){
        int j = rand()%n+1;
        if(s[j]==0){
            s[j] = 1;
            i++;
        }
    }
    return s;
}

numset setdestroy(numset s){
    //Make S an invalid set
    s[0] = -1;
    return s;
}

