#Default variables
SHELL = /bin/sh
CC = gcc
CFLAGS = -O2 -g -I.
RM = rm -f

OBJFILES = soln2.o 

soln2.o : soln2.h
	$(CC) $(CFLAGS) -c soln2.c

clean: 
	-$(RM) $(OBJFILES)

