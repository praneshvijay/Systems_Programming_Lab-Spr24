#include<stdio.h>
#include "soln3.h"

int findterm3(int n, recrel3 r){

    int a[n+1];
    a[0] = r.a0;
    a[1] = r.a1;
    a[2] = r.a2;
    for(int i=3; i<=n; i++){
        a[i] = r.c1*a[i-1] + r.c2*a[i-2] + r.c3*a[i-3] + r.d;
    }
    return a[n];
}