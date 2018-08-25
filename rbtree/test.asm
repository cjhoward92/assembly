section .bss
	node: resb 32

section .data

section .text

global _start

_start:
	nop

	mov eax, node

	nop

Exit:
	mov rax, 60
	mov rdi, 0
	syscall
