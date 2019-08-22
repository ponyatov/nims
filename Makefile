
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

# mips-openwrt-linux-gcc -g -lm -lusb-1.0 -o dcled dcled.c

cross: hello.mips
hello.mips: hello.c Makefile
	$(CC) -o $@ $< && $(SZ) $@

hello: hello.nim Makefile
	nim c $< && ls -la $@ && $(OD) -x $@
