
CWD  = $(CURDIR)
GZ  ?= $(HOME)/gz
LIB  = $(CWD)/prefix

MODBUS_VER	= 3.1.6
MODBUS		= libmodbus-$(MODBUS_VER)
MODBUS_GZ	= $(MODBUS).tar.gz

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
