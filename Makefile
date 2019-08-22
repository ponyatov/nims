
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

# mips-openwrt-linux-gcc -g -lm -lusb-1.0 -o dcled dcled.c

debug: hello.mips
	$(GDB) -ex "target extended-remote localhost:$(PORT)" \
		-ex "set remote exec-file /tmp/$<" \
		-ex "run" $<
# target$ gdbserver --multi 111.111.111.111:12345

remote: hello.mips
	ssh root@$(IP) -L $(IP):$(PORT):localhost:$(PORT) 'gdbserver --multi localhost:$(PORT)'

cross: hello.mips
hello.mips: hello.c Makefile
	$(CC) -o $@ $< && echo ; file $@ ; $(SZ) $@
	# scp $@ root@$(IP):/$@

hello: hello.nim Makefile
	nim c $< && ls -la $@ && $(OD) -x $@
