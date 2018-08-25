eatterm: eatterm.o
	ld eatterm.o -o eatterm

eatterm.o: term.asm
	nasm -f elf64 -F dwarf -g term.asm -l term.lst -o eatterm.o
