run: bare
	qemu-system-x86_64 -enable-kvm -kernel $<
bare: bare.nim bare.nim.cfg multiboot.S panicoverride.nim Makefile
	PATH=../cross/bin:$(PATH) nim c --gcc.exe:"kvm-gcc" $<

