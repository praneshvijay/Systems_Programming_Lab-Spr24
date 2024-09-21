#include<stdio.h>   
#include "../lib/order1/soln1.h"
#include "../lib/order2/soln2.h"
#include "../lib/order3/soln3.h"


int main(){
    int n; printf("n = ");
    scanf("%d", &n);

    recrel1 ToH = {0, 2, 1};
    recrel2 Fib5 = {5, 6, 1, 1, -5};
    recrel3 Fib = {0, 1, 1, 0, 2, 1, 0};
    printf("ToH(%d) = %d\n", n, findterm1(n, ToH));
    printf("Fib(%d) + 5 = %d\n", n, findterm2(n, Fib5));
    printf("Fib(%d) = %d\n", n, findterm3(n, Fib));
    return 0;
}
