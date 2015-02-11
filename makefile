.SUFFIXES:
.PHONY: build clean cleanall shell

#DARTSDK = /opt/google/dartsdk

build:
	gcc-4.8 -std=c++11 -fPIC -O2 -I$(DART_SDK) -c -o sqlite.o lib/src/sqlite.cc
	gcc-4.8 -fPIC -O2 -DSQLITE_THREADSAFE=1 -DSQLITE_OMIT_LOAD_EXTENSION -c -o sqlite3.o lib/src/sqlite3.c
	gcc-4.8 -shared -Wl,-soname,libsqlite.so -o lib/libsqlite.so sqlite.o sqlite3.o
	# gcc-4.8 -fPIC -O2 -c -o sha1.o lib/src/sha1.c
	# gcc-4.8 -shared -Wl,-soname,libsqlite.so -o lib/libsqlite.so sqlite.o sqlite3.o sha1.o

shell:
	gcc-4.8 -pthread -O2 -DSQLITE_THREADSAFE=1 -DSQLITE_OMIT_LOAD_EXTENSION -o bin/sqlite3 lib/src/shell.c lib/src/sqlite3.c

clean:
	rm -f *.o

cleanall: clean
	rm -f lib/libsqlite.so bin/sqlite3
