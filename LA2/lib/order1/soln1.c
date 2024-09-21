#include<stdio.h>
#include "soln1.h"

int findterm1(int n, recrel1 r){

    int a[n+1];
    a[0] = r.a0;
    for(int i=1; i<=n; i++){
        a[i] = r.c1*a[i-1] + r.d;
    }
    return a[n];
}