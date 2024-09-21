#Default variables
SHELL = /bin/sh
CC = gcc
CFLAGS = -O2 -g -I.
RM = rm -f

OBJFILES = soln3.o 

soln3.o : soln3.h
	$(CC) $(CFLAGS) -c soln3.c

clean: 
	-$(RM) $(OBJFILES)

