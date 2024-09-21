#Makefile for building static setutils library

#Default variables
SHELL = /bin/sh
CC = gcc
CFLAGS = -O2 -g -I.
AR = ar
RM = rm -f

#Library name
LIBNAME = librecrel.a

OBJFILES = 	order1/soln1.o order2/soln2.o order3/soln3.o

library:
	cd order1; make
	cd order2; make
	cd order3; make
	$(AR) rcs $(LIBNAME) $(OBJFILES)

clean: 
	cd order1; make clean
	cd order2; make clean
	cd order3; make clean

distclean: 
	-$(RM) $(OBJFILES) $(LIBNAME)


