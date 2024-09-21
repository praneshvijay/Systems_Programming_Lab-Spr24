#ifndef SETTOPS_H
#define SETTOPS_H

#include "settype.h"

void setprint(numset S);
int setsize(numset S);
numset setaddelt(numset S, int i);
numset setdelelt(numset S, int i);
numset setunion(numset A, numset B);
numset setintersection(numset A, numset B);

#endif