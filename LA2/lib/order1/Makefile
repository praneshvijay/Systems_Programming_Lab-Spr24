#Default variables
SHELL = /bin/sh
CC = gcc
CFLAGS = -O2 -g -I.
RM = rm -f

OBJFILES = soln1.o 

soln1.o : soln1.h
	$(CC) $(CFLAGS) -c soln1.c

clean: 
	-$(RM) $(OBJFILES)

