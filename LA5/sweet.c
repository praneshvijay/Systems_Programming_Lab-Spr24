#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

typedef struct {
   int N;
   int *A;
} coupons;
coupons initempty ( int ) ;
void destroycoupons ( coupons * ) ;
coupons addcoupon ( coupons, int ) ;
int allcoupons ( coupons ) ;

coupons initempty ( int N )
{
   coupons S;
   S.N = N;
   S.A = (int *)calloc((N+1), sizeof(int));
   return S;
}

coupons addcoupon ( coupons S, int c )
{
   if(S.A[c] == 0) {
      S.A[c] = 1;
      S.A[S.N]++;
   }
   return S;
}

int allcoupons ( coupons S )
{
   return (S.A[S.N] == S.N);
}

void destroycoupons ( coupons *S )
{
   free(S -> A);
}

#include "choco.c"
