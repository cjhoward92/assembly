uppercaser: uppercaser.o
	ld uppercaser.o -o uppercaser

uppercaser.o: uppercaser.asm
	nasm -f elf64 -F dwarf -g uppercaser.asm -l uppercaser.lst
