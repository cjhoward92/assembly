hexdump: hexdump.o
	ld hexdump.o -o hexdump

hexdump.o: hexdump.asm
	nasm -f elf64 -F dwarf -g hexdump.asm -l hexdump.lst
