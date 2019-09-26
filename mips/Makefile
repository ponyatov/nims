
GCC_VER			= 7.3.0
OPENWRT_VER		= 18.06.4
OPENWRT			= $(HOME)/ICBLINK/openwrt-$(OPENWRT_VER)
STAGING			= $(OPENWRT)/staging_dir
TOOLCHAIN		= $(STAGING)/toolchain-mipsel_24kc_gcc-$(GCC_VER)_musl

LDCFLAGS		= $(TOOLCHAIN)/usr/lib
LD_LIBRARY_PATH	= $(TOOLCHAIN)/usr/lib

TARGET			= mipsel-openwrt-linux-musl
LIBRARY_PATH	= $(TOOLCHAIN)/lib/gcc/$(TARGET)/$(GCC_VER)
XPATH 			= PATH=$(TOOLCHAIN)/bin:$(TOOLCHAIN)/host/bin:$(HOME)/.nimble/bin STAGING_DIR=$(STAGING)

CC  = $(TARGET)-gcc
CXX = $(TARGET)-g++
LD  = $(TARGET)-ld
LDD = $(TARGET)-ldd
SZ  = $(TARGET)-size
OD  = $(TARGET)-objdump
GDB = $(TARGET)-gdb

IP   ?= 111.111.111.111
PORT ?= 12345

debug: hello_nim
	$(XPATH) $(GDB)	-ex "target extended-remote $(IP):$(PORT)" \
					-ex "set sysroot $(STAGING)" \
					-ex "remote put $< /tmp/$<" \
					-ex "set remote exec-file /tmp/$<" \
					-ex "run" $<
remote:
	xterm -e ssh root@$(IP) 'gdbserver --multi $(IP):$(PORT)' &

hello_c: src/hello.c Makefile
	$(XPATH) $(CC) -o $@ $<
	@file $@ ; ls -la $@
	@$(XPATH) $(SZ) $@

hello_nim: src/hello.nim src/nim.cfg Makefile
	$(XPATH) nim cpp -o:$@ $<
	@file $@ ; ls -la $@
	@$(XPATH) $(SZ) -x $@
	@$(XPATH) $(OD) -x $@ | grep -i GLIBC
	@$(XPATH) $(OD) -x $@ | grep -i c++.so
