kangaroo: kangaroo.o
	ld kangaroo.o -o kangaroo

kangaroo.o: kangaroo.asm
	nasm -f elf64 -F dwarf -g kangaroo.asm -l kangaroo.lst
