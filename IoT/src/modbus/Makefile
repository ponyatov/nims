
CWD  = $(CURDIR)
GZ  ?= $(HOME)/gz
LIB  = $(CWD)/prefix

MODBUS_VER	= 3.1.6
# 3.0.8
MODBUS		= libmodbus-$(MODBUS_VER)
MODBUS_GZ	= $(MODBUS).tar.gz

NIMS  = modbus.c.nim

lib: $(NIMS)

modbus.c.nim: $(CWD)/build/src/modbus.c.004t.gimple ./gimple2nim Makefile
	./gimple2nim < $< > $@

./gimple2nim: gimple2nim_lex.cpp gimple2nim_yacc.cpp
	g++ -o $@ $^
gimple2nim_lex.cpp: gimple2nim.lex
	flex -o $@ $<
gimple2nim_yacc.cpp: gimple2nim.yacc
	bison -o $@ $<

MODBUS_CFG = CFLAGS='-O0 -fdump-tree-gimple'\
				--prefix=$(LIB) --disable-shared --enable-static \
				--disable-tests --without-documentation \
			
MAKE  ?= make
MAKEJ  = $(MAKE) -j$(shell grep proc /proc/cpuinfo|wc -l)

$(LIB)/lib/libmodbus.a: $(CWD)/$(MODBUS)/configure
	rm -rf $(CWD)/build ; mkdir $(CWD)/build ; cd $(CWD)/build ; \
	$< $(MODBUS_CFG) && $(MAKEJ) && $(MAKE) install

$(CWD)/$(MODBUS)/configure: $(CWD)/$(MODBUS)/README.rst
	cd $(MODBUS) ; sh autogen.sh

$(CWD)/$(MODBUS)/README.rst: $(GZ)/$(MODBUS_GZ)
	tar zx < $< && touch $@

$(GZ)/$(MODBUS_GZ): 
	wget -c -O $@ https://github.com/stephane/libmodbus/archive/v$(MODBUS_VER).tar.gz
