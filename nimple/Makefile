C = nimple_yacc.cpp nimple_lex.cpp 
H = nimple_yacc.hpp nimple.hpp
./nimple$(EXE): $(C) $(H) Makefile
	$(CXX) $(CXXFLAGS) -o $@ $(C)
nimple_yacc.cpp: nimple.yacc
	bison -o $@ $<
nimple_lex.cpp: nimple.lex
	flex -o $@ $<
