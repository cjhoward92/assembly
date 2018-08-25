multiply: multiply.o
	ld multiply.o -o multiply

multiply.o: multiply.asm
	nasm -f elf64 -F dwarf -g multiply.asm -l multiply.lst
