
GZ ?= $(HOME)/gz

MODBUS_VER	= 3.0.8
MODBUS		= libmodbus-$(MODBUS_VER)
MODBUS_GZ	= $(MODBUS).tar.gz

NIMS  = modbus.h.nim

lib: $(NIMS)

%.nim: $(MODBUS)/src/% $(MODBUS)/README.rst Makefile
	c2nim --out:$@ $<

$(MODBUS)/README.rst: $(GZ)/$(MODBUS_GZ)
	tar zx < $< && touch $@

$(GZ)/$(MODBUS_GZ): 
	wget -c -O $@ https://github.com/stephane/libmodbus/archive/v$(MODBUS_VER).tar.gz