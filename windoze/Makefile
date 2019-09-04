EXE ?= .exe
exec: windoze$(EXE)
	./$<
%$(EXE): src/%.nim %.nimble
	nimble build
