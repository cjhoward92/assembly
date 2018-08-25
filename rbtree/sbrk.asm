section .text

global _start

_start:
	nop

	mov rbx, 1000

	mov rax, 12
	mov rdi, 0
	syscall

	nop

	mov rax, 60
	mov rdi, 0
	syscall
