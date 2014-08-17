
CC = /usr/bin/gcc
CFLAGS = -std=gnu99 -Wall -Wextra -pedantic -Os
LIBS = -lssl

OBJS = revsh_io.o string_to_vector.o broker.o

all: revsh

revsh: revsh.c revsh.h remote_io_helper.h common.h $(OBJS)
	if [ ! -e dh_params_2048.c ]; then openssl dhparam -C 2048 -noout >dh_params_2048.c ; fi
	$(CC) $(LIBS) $(CFLAGS) $(OBJS) -o revsh revsh.c

revsh_io: revsh_io.c revsh_io.h remote_io_helper.h common.h
	$(CC) $(LIBS) $(CFLAGS) -c -o revsh_io.o revsh_io.c

string_to_vector: string_to_vector.c string_to_vector.h common.h
	$(CC) $(CFLAGS) -c -o string_to_vector.o string_to_vector.c

broker: broker.c broker.h common.h
	$(CC) $(CFLAGS) -c -o broker.o broker.c

clean:
	rm revsh dh_params_2048.c $(OBJS)
