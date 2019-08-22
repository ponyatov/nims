cross: hello
hello: hello.nim Makefile
	nim c $< && ls -la $@ && ldd $@
	./$@
