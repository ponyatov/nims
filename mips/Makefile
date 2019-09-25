OPENWRT		= $(HOME)/ICBLINK/openwrt-18.06.4
STAGING		= $(OPENWRT)/staging_dir
TOOLCHAIN	= $(STAGING)/toolchain-mipsel_24kc_gcc-7.3.0_musl

LDCFLAGS		= $(TOOLCHAIN)/usr/lib
LD_LIBRARY_PATH	= $(TOOLCHAIN)/usr/lib

LIBRARY_PATH = $(TOOLCHAIN)/lib/gcc/mipsel-openwrt-linux-musl/7.3.0
XPATH		= PATH=$(TOOLCHAIN)/bin:$(PATH) LIBRARY_PATH=$(LIBRARY_PATH)

TARGET		= mipsel-openwrt-linux-musl

CC  = $(TARGET)-gcc
LD  = $(TARGET)-ld
SZ  = $(TARGET)-size
OD  = $(TARGET)-objdump
GDB = $(TARGET)-gdb

IP   ?= 111.111.111.111
PORT ?= 12345

   IP_FORWARDING = $(IP)
# GDB_FORWARDING = -L $(PORT):$(IP):$(PORT)
#  IP_FORWARDING = localhost

debug: hello_nim
	$(XPATH) $(GDB)	-ex "target extended-remote $(IP_FORWARDING):$(PORT)" \
					-ex "set sysroot $(STAGING)" \
					-ex "remote put $< /tmp/$<" \
					-ex "set remote exec-file /tmp/$<" \
					-ex "run" $<
remote:
	xterm -e ssh root@$(IP) $(GDB_FORWARDING) 'gdbserver --multi $(IP_FORWARDING):$(PORT)'

hello_c: src/hello.c Makefile
	$(XPATH) $(CC) -o $@ $<
	@file $@ ; ls -la $@
	@$(XPATH) $(SZ) $@

hello_nim: src/hello.nim src/nim.cfg Makefile
	$(XPATH) nim c -o:$@ $<
	@file $@ ; ls -la $@
	@$(XPATH) $(SZ) -x $@
