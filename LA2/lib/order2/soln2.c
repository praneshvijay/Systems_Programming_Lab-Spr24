#include<stdio.h>
#include "soln2.h"

int findterm2(int n, recrel2 r){
    int a[n+1];
    a[0] = r.a0;
    a[1] = r.a1;
    for(int i=2; i<=n; i++){
        a[i] = r.c1*a[i-1] + r.c2*a[i-2] + r.d;
    }
    return a[n];
}