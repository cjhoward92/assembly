section .data
	BRK 		equ 	12
	SCTLEN		equ	16	

section .bss
	HeapStart	resq	1
	SctCnt		resq	1	

section .text

global _start

_start:
	nop				; for GDB

	mov rbx, 3			; Number of times to allocate
	mov qword [SctCnt], 0			; Initialize SctCnt to 0
	mov rax, BRK			; Call sys_brk
	mov rdi, 0			; Initialize the beginning of the heap
	syscall

	mov qword [HeapStart], rax	; Move the starting address of the head to HeapStart

Alloc:	lea rdi, [rax+SCTLEN]		; Load the address of rax + SCTLEN into rdi for heap growth
	mov rax, BRK			; Call sys_brk
	syscall

	mov byte [rdi], 0x1
	mov byte [rdi+1], 'a'
	mov byte [rdi+2], 'D'
	mov byte [rdi+3], 100 	

	mov rcx, [SctCnt]
	inc rcx
	mov qword [SctCnt], rcx
	dec rbx
	jnz Alloc

	mov rax, 60
	mov rdi, 0
	syscall
