@clean:
	make clean

@build:
	make

@run: build
	fnxmgr --address 2000 --binary test.bin

@clear:
	dd if=/dev/zero of=_zero.bin bs=1024 count=64
	fnxmgr --address 0 --binary _zero.bin
	rm _zero.bin

@zip:
	rm -f release.zip
	zip release.zip monitor.bin trampoline.bin test.bin
	