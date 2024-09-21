#include<stdio.h>
#include<stdlib.h>
#include "setops.h"

void setprint(numset s){
    printf("{");
    for(int i=1;i<=s[0];i++){
        if(s[i]==1){
            printf("%d,",i);
        }
    }
    printf("\b}\n");
}

int setsize(numset s){
    int count=0;
    for(int i=1;i<=s[0];i++){
        if(s[i]==1){
            count++;
        }
    }
    return count;
}

numset setaddelt(numset s,int i){
    s[i]=1;
    return s;
}

numset setdelelt(numset s,int i){
    s[i]=0;
    return s;
}

numset setunion(numset s1,numset s2){
    numset s3 = setinit(s1[0]);
    for(int i=1;i<=s1[0];i++){
        if(s1[i]==1 || s2[i]==1){
            s3[i]=1;
        }
        else{
            s3[i]=0;
        }
    }
    return s3;
}

numset setintersection(numset s1,numset s2){
    numset s3 = setinit(s1[0]);
    for(int i=1;i<=s1[0];i++){
        if(s1[i]==1 && s2[i]==1){
            s3[i]=1;
        }
        else{
            s3[i]=0;
        }
    }
    return s3;
}

