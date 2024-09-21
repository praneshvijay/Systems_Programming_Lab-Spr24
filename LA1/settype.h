#ifndef SETTYPE_H
#define SETTYPE_H

typedef int* numset;

numset setinit(int n);
numset setrand(int n);
numset setrandsize(int n, int t);
numset setdestroy(numset S);

#endif