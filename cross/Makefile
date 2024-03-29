HW ?= kvm

include hw/$(HW).mk
include cpu/$(CPU).mk
include arch/$(ARCH).mk

BINUTILS_VER	= 2.32
GCC_VER			= 9.2.0
GMP_VER			= 6.1.2
MPFR_VER		= 4.0.2
MPC_VER			= 1.1.0
NEWLIB_VER		= 3.1.0

BINUTILS	= binutils-$(BINUTILS_VER)
BINUTILS_GZ	= $(BINUTILS).tar.xz

GCC			= gcc-$(GCC_VER)
GCC_GZ		= $(GCC).tar.xz

GMP			= gmp-$(GMP_VER)
GMP_GZ		= $(GMP).tar.xz

MPFR		= mpfr-$(MPFR_VER)
MPFR_GZ		= $(MPFR).tar.xz

MPC			= mpc-$(MPC_VER)
MPC_GZ		= $(MPC).tar.gz

NEWLIB		= newlib-$(NEWLIB_VER)
NEWLIB_GZ	= $(NEWLIB).tar.gz

CWD = $(CURDIR)
GZ  = $(HOME)/gz
TMP = $(CWD)/tmp
SRC = $(TMP)/src
SSR = $(CWD)/sysroot

build: dirs gcc0 libc gcc

clean:
	rm -rf $(CWD)/bin $(CWD)/lib $(CWD)/share $(CWD)/include $(TMP) $(SSR) $(CWD)/$(TARGET)

dirs:
	mkdir -p $(GZ) $(TMP) $(SRC) $(SSR)

XPATH = PATH=$(CWD)/bin:$(PATH)
CFG   = configure --disable-nls --prefix=$(CWD)
MAKE := $(XPATH) $(MAKE)
MAKEJ = $(MAKE) -j$(shell grep proc /proc/cpuinfo|wc -l)

CCLIBS_PFX = --with-gmp=$(CWD) --with-mpfr=$(CWD) --with-mpc=$(CWD)

binutils: bin/$(TARGET)-ld

BINUTILS_CFG = $(CCLIBS_PFX) --target=$(TARGET) --with-sysroot=$(SSR)

bin/$(TARGET)-ld: $(GZ)/$(BINUTILS_GZ)
	$(MAKE) $(SRC)/$(BINUTILS)/README 
	rm -rf $(TMP)/$(BINUTILS) ; mkdir $(TMP)/$(BINUTILS) ; cd $(TMP)/$(BINUTILS) ;\
		$(SRC)/$(BINUTILS)/$(CFG) $(BINUTILS_CFG) && $(MAKEJ) && $(MAKE) install-strip &&\
		rm -rf $(SRC)/$(BINUTILS) $(TMP)/$(BINUTILS)

gcc0: cclibs binutils bin/$(TARGET)-gcc

GCC0_CFG = $(BINUTILS_CFG) --without-headers --with-newlib --enable-languages="c"

bin/$(TARGET)-gcc: $(GZ)/$(GCC_GZ)
	$(MAKE) $(SRC)/$(GCC)/README
	rm -rf $(TMP)/$(GCC) ; mkdir $(TMP)/$(GCC) ; cd $(TMP)/$(GCC) ;\
		$(XPATH) $(SRC)/$(GCC)/$(CFG) $(GCC0_CFG) &&\
			$(MAKE) -j2 all-gcc all-target-libgcc &&\
			$(MAKE) install-gcc install-target-libgcc &&\
	rm -rf $(TMP)/$(GCC)

GCC_CFG = $(GCC0_CFG)

gcc: libc $(GZ)/$(GCC_GZ)
	$(MAKE) $(SRC)/$(GCC)/README
	rm -rf $(TMP)/$(GCC) ; mkdir $(TMP)/$(GCC) ; cd $(TMP)/$(GCC) ;\
		$(XPATH) $(SRC)/$(GCC)/$(CFG) $(GCC_CFG) &&\
			$(MAKE) -j2 all-gcc all-target-libgcc &&\
			$(MAKE) install-gcc install-target-libgcc &&\
	rm -rf $(TMP)/$(GCC) $(SRC)/$(GCC)

cclibs: gmp mpfr mpc

CCLIBS_CFG = $(CCLIBS_PFX) --disable-shared 

gmp: $(CWD)/lib/libgmp.a

GMP_CFG = $(CCLIBS_CFG)

$(CWD)/lib/libgmp.a: $(GZ)/$(GMP_GZ)
	$(MAKE) $(SRC)/$(GMP)/README
	rm -rf $(TMP)/$(GMP) ; mkdir $(TMP)/$(GMP) ; cd $(TMP)/$(GMP) ;\
		$(SRC)/$(GMP)/$(CFG) $(GMP_CFG) && $(MAKEJ) && $(MAKE) install-strip &&\
		rm -rf $(SRC)/$(GMP) $(TMP)/$(GMP)

mpfr: $(CWD)/lib/libmpfr.a

MPFR_CFG = $(CCLIBS_CFG)

$(CWD)/lib/libmpfr.a: $(GZ)/$(MPFR_GZ)
	$(MAKE) $(SRC)/$(MPFR)/README
	rm -rf $(TMP)/$(MPFR) ; mkdir $(TMP)/$(MPFR) ; cd $(TMP)/$(MPFR) ;\
		$(SRC)/$(MPFR)/$(CFG) $(MPFR_CFG) && $(MAKEJ) && $(MAKE) install-strip &&\
		rm -rf $(SRC)/$(MPFR) $(TMP)/$(MPFR)

mpc: $(CWD)/lib/libmpc.a

MPC_CFG = $(CCLIBS_CFG)

$(CWD)/lib/libmpc.a: $(GZ)/$(MPC_GZ)
	$(MAKE) $(SRC)/$(MPC)/README
	rm -rf $(TMP)/$(MPC) ; mkdir $(TMP)/$(MPC) ; cd $(TMP)/$(MPC) ;\
		$(SRC)/$(MPC)/$(CFG) $(MPC_CFG) && $(MAKEJ) && $(MAKE) install-strip &&\
		rm -rf $(SRC)/$(MPC) $(TMP)/$(MPC)

$(SRC)/%/README: $(GZ)/%.tar.xz
	cd $(SRC) ; xzcat $< | tar x && touch $@
$(SRC)/%/README: $(GZ)/%.tar.gz
	cd $(SRC) ;  zcat $< | tar x && touch $@

$(GZ)/$(BINUTILS_GZ):
	wget -c -O $@ https://mirror.tochlab.net/pub/gnu/binutils/binutils-2.32.tar.xz && touch $@

$(GZ)/$(GCC_GZ): $(GZ)/$(GMP_GZ) $(GZ)/$(MPFR_GZ)
	wget -c -O $@ ftp://ftp.nluug.nl/mirror/languages/gcc/releases/$(GCC)/$(GCC_GZ) && touch $@

$(GZ)/$(GMP_GZ):
	wget -c -O $@ https://gmplib.org/download/gmp/$(GMP_GZ) && touch $@

$(GZ)/$(MPFR_GZ):
	wget -c -O $@ https://www.mpfr.org/mpfr-current/$(MPFR_GZ) && touch $@

$(GZ)/$(MPC_GZ):
	wget -c -O $@ https://ftp.gnu.org/gnu/mpc/$(MPC_GZ) && touch $@

NEWLIB_CFG = --target=$(TARGET) --prefix=$(SSR)

libc: $(SSR)/$(TARGET)/include/stdlib.h
$(SSR)/$(TARGET)/include/stdlib.h: $(GZ)/$(NEWLIB_GZ)
	$(MAKE) $(SRC)/$(NEWLIB)/README
	rm -rf $(TMP)/$(NEWLIB) ; mkdir $(TMP)/$(NEWLIB) ; cd $(TMP)/$(NEWLIB) ;\
		$(XPATH) $(SRC)/$(NEWLIB)/$(CFG) $(NEWLIB_CFG) &&\
			$(MAKEJ) && $(MAKE) install &&\
	rm -rf $(SRC)/$(NEWLIB) $(TMP)/$(NEWLIB)

$(SRC)/$(NEWLIB)/README: $(GZ)/$(NEWLIB_GZ)
	cd $(SRC) ; tar zx < $< ; mv newlib-$(NEWLIB) $(NEWLIB) ; touch $@

$(GZ)/$(NEWLIB_GZ):
	wget -c -O $@ https://github.com/bminor/newlib/archive/newlib-3.1.0.tar.gz
