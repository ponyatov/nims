
WRT			= $(HOME)/ICBLINK/openwrt-18.06.4
STAGING		= $(WRT)/staging_dir
TOOLCHAIN	= $(STAGING)/toolchain-mipsel_24kc_gcc-7.3.0_musl
XPATH		= $(TOOLCHAIN)/bin:$(PATH)

LDCFLAGS		= $(TOOLCHAIN)/usr/lib
LD_LIBRARY_PATH	= $(TOOLCHAIN)/usr/lib

TARGET		= mipsel-openwrt-linux

CC	= PATH=$(XPATH) STAGING_DIR=$(STAGING) $(TARGET)-gcc
LD	= PATH=$(XPATH) STAGING_DIR=$(STAGING) $(TARGET)-ld
OD	= PATH=$(XPATH) STAGING_DIR=$(STAGING) $(TARGET)-objdump
NM	= PATH=$(XPATH) STAGING_DIR=$(STAGING) $(TARGET)-nm
ELF = PATH=$(XPATH) STAGING_DIR=$(STAGING) $(TARGET)-readelf
SZ  = PATH=$(XPATH) STAGING_DIR=$(STAGING) $(TARGET)-size
GDB = PATH=$(XPATH) STAGING_DIR=$(STAGING) $(TARGET)-gdb

IP   ?= 111.111.111.111
PORT ?= 12345

   IP_FORWARDING = $(IP)
# GDB_FORWARDING = -L $(PORT):$(IP):$(PORT)
#  IP_FORWARDING = localhost

debug: hello.mips
	$(GDB)	-ex "target extended-remote $(IP_FORWARDING):$(PORT)" \
			-ex "set sysroot $(STAGING)" \
			-ex "remote put $< /tmp/$<" \
			-ex "set remote exec-file /tmp/$<" \
			-ex "run" $<
remote:
	ssh root@$(IP) $(GDB_FORWARDING) 'gdbserver --multi $(IP_FORWARDING):$(PORT)'

cross: hello.mips
hello.mips: hello.c Makefile
	$(CC) -o $@ $< && echo ; file $@ ; $(SZ) $@
	# scp $@ root@$(IP):/$@

hello: hello.nim Makefile
	nim c $< && ls -la $@ && $(OD) -x $@
