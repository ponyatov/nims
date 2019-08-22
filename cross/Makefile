HW ?= kvm

include hw/$(HW).mk
include cpu/$(CPU).mk
include arch/$(ARCH).mk

GCC_VER = 9.2.0

GCC		= gcc-$(GCC_VER)
GCC_GZ	= $(GCC).tar.xz

CWD = $(CURDIR)
GZ  = $(CWD)/gz
TMP = $(CWD)/tmp
SRC = $(TMP)/src

build: bin/$(TARGET)-gcc

CFG = configure --disable-nls --prefix=$(CWD)/gcc --target=$(TARGET)

bin/$(TARGET)-gcc: $(SRC)/$(GCC)/README
	rm -rf $(TMP)/$(GCC) ; mkdir $(TMP)/$(GCC) ; cd $(TMP)/$(GCC) ;\
		$(SRC)/$(GCC)/$(CFG)

dirs:
	mkdir -p $(GZ) $(TMP) $(SRC)

$(SRC)/%/README: $(GZ)/%.tar.xz
	cd $(SRC) ; xzcat $< | tar x && touch $@

$(GZ)/$(GCC_GZ):
	wget -c -O $@ http://mirror.linux-ia64.org/gnu/gcc/releases/$(GCC)/$(GCC_GZ)
