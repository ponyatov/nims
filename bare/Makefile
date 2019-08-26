XPATH = PATH=../cross/bin:$(PATH)
run: bare
	qemu-system-x86_64 -enable-kvm -kernel $<
bare: bare.nim bare.nim.cfg multiboot.S panicoverride.nim Makefile
	$(XPATH) nim c $<
