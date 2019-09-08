
CWD  = $(CURDIR)
GZ  ?= $(HOME)/gz
LIB  = $(CWD)/prefix

MODBUS_VER	= 3.1.6
MODBUS		= libmodbus-$(MODBUS_VER)
MODBUS_GZ	= $(MODBUS).tar.gz

MAKE  ?= make
MAKEJ  = $(MAKE) -j$(shell grep proc /proc/cpuinfo|wc -l)

GIMPLE		= -O0 -fdump-tree-gimple -fdump-tree-original
GIMPLE_CFG	= CFLAGS="$(GIMPLE)"

sample/hello_c: sample/hello.c sample/Makefile Makefile
	$(MAKE) -C sample CFLAGS="$(GIMPLE)"

MODBUS_CFG = $(GIMPLE_CFG) \
				--prefix=$(LIB) --disable-shared --enable-static \
				--disable-tests --without-documentation

modbus: $(LIB)/lib/libmodbus.a

$(LIB)/lib/libmodbus.a: $(CWD)/$(MODBUS)/configure
	rm -rf $(CWD)/build ; mkdir $(CWD)/build ; cd $(CWD)/build ; \
	$< $(MODBUS_CFG) && $(MAKEJ) && $(MAKE) install

$(CWD)/$(MODBUS)/configure: $(CWD)/$(MODBUS)/README.md
	cd $(MODBUS) ; sh autogen.sh

$(CWD)/$(MODBUS)/README.md: $(GZ)/$(MODBUS_GZ)
	tar zx < $< && touch $@

$(GZ)/$(MODBUS_GZ): 
	wget -c -O $@ https://github.com/stephane/libmodbus/archive/v$(MODBUS_VER).tar.gz

C = nimple_yacc.cpp nimple_lex.cpp 
H = nimple_yacc.hpp nimple.hpp
./nimple$(EXE): $(C) $(H) Makefile
	$(CXX) $(CXXFLAGS) -o $@ $(C)
nimple_yacc.cpp: nimple.yacc
	bison -o $@ $<
nimple_lex.cpp: nimple.lex
	flex -o $@ $<
