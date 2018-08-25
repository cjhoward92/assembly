strings: strings.o
	ld strings.o -o strings

strings.o: strings.asm
	nasm -f elf64 -F dwarf -g strings.asm -l strings.lst
