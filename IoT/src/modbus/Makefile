MODBUS_VER	= 3.0.8
MODBUS		= libmodbus-$(MODBUS_VER)
MODBUS_GZ	= $(MODBUS).tar.gz

$(MODBUS)/README: $(MODBUS_GZ)
	tar zx < $< && touch $@

$(MODBUS_GZ): 
	wget -c -O $@ https://github.com/stephane/libmodbus/archive/v$(MODBUS_VER).tar.gz