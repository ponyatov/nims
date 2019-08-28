# https://developer.gnome.org/gtk-tutorial/stable/x111.html

CFLAGS  += $(shell pkg-config --cflags gtk+-3.0)
LDFLAGS += $(shell pkg-config --ldflasg gtk+-3.0)

L += $(shell pkg-config --libs gtk+-3.0)
C += gui.c

CFLAGS += -fdump-tree-all

./gui: $(C) Makefile
	$(CC) $(CFLAGS) -o $@ $(C) $(L)