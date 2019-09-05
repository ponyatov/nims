g: nimos$(EXE)
	./$<
nimos$(EXE): src/*.nim nimos.nimble Makefile res/nimos.res
	nimble build
res/nimos.res: res/nimos.rc res/*.ico
	windres -O coff -o $@ $<
