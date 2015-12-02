EXECUTABLE=albion
CC = gcc
LIBS = -lssl -lcrypto  -lnsl -lcurl -lxml2 lib/libircclient.a
INCLUDES= -Iinclude -Ilib/include -I/usr/include/libxml2 -I/usr/include/curl
CFLAGS = -g -Wall -march=x86-64 -mtune=generic -O2 -pipe -fstack-protector-strong -O3 -fpic -DENABLE_SSL -Llib $(INCLUDES)

SRC = $(wildcard src/*.c)
PREREQ_WILD = $(patsubst %.c, %.o, $(SRC))


$(EXECUTABLE): lib/config.h $(PREREQ_WILD)
	$(CC) $(CFLAGS) $(PREREQ_WILD) -o $@ $(LIBS)

lib/config.h:
	./lib/configure
	mv ./src/config.h ./lib
	mv ./config.log ./lib
	mv ./config.status ./lib
	$(MAKE) -C ./lib


clean:
	rm -f src/*.o  $(EXECUTABLE)
