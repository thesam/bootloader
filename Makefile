NASM=nasm
QEMU=qemu-system-i386

all: floppy.img

.PHONY: clean run

floppy.img: boot.bin os.bin
	dd if=/dev/zero of=$@ bs=512 count=2 &>/dev/null
	cat $^ | dd if=/dev/stdin of=$@ conv=notrunc &>/dev/null

boot.bin: boot.asm
	$(NASM) -o $@ -f bin $<

os.bin: os.asm
	$(NASM) -o $@ -f bin $<


run: floppy.img
	$(QEMU) -fda $<

clean:
	rm -f *.bin *.img
