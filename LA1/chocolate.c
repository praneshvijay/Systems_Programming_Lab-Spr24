#include<stdio.h>
#include<stdlib.h>
#include "setops.h"
#include<time.h>
#include "settype.h"

int howmanypackets(unsigned int n){
    int ans = 0;
    numset s = setinit(n);
    while(setsize(s)<n){
        int r = rand()%n+1;
        setaddelt(s,r);
        ans++;
    }
    return ans;
}

int main(){
    unsigned int n;
    printf("Number of coupons (N): ");
    scanf("%d",&n);
    srand((unsigned int)time(NULL));

    #ifdef STAT_MODE
    printf("+++ Statistics Mode\n");
    float avg = 0;
    int itr = 1000;
    for(int i=0;i<itr;i++){
        avg += howmanypackets(n);
    }
    avg = avg/itr;
    printf("--- Average number of packets to buy = %f\n\n",avg);

    #else
    printf("+++ Interactive Mode\n");
    numset s = setinit(n);
    int itr =1;
    while(setsize(s)<n){
        int r = rand()%n+1;
        setaddelt(s,r);
        printf("Packet %d has coupon %d, ",itr,r);
        printf("Available coupons: ");
        setprint(s);
        itr++;
    }
    printf("---%d packets were bought\n\n",itr-1);
    #endif
}