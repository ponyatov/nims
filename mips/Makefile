WRT			= $(HOME)/openwrt-18.06.4
STAGING		= $(WRT)/staging_dir
TOOLCHAIN	= $(STAGING)/toolchain-mipsel_24kc_gcc-7.3.0_musl
XPATH		= PATH=$(TOOLCHAIN)/bin:$(PATH) STAGING_DIR=$(STAGING)

LDCFLAGS		= $(TOOLCHAIN)/usr/lib
LD_LIBRARY_PATH	= $(TOOLCHAIN)/usr/lib

TARGET		= mipsel-openwrt-linux

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
	ssh root@$(IP) $(GDB_FORWARDING) 'gdbserver --multi $(IP_FORWARDING):$(PORT)'

hello_c: hello.c Makefile
	$(XPATH) $(CC) -o $@ $< && echo
	file $@ ; ls -la $@
	$(XPATH) $(SZ) $@

hello_nim: hello.nim hello.nim.cfg Makefile
	$(XPATH) nim c -o:$@ $<
	file $@ ; ls -la $@
	$(XPATH) $(SZ) -x $@
