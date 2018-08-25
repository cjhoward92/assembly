section .bss
	BUFF_LEN equ 16
	Buff: resb BUFF_LEN

section .data
	SYS_WRITE equ 1
	SYS_READ equ 0
	SYS_EXIT equ 60
	STDIN equ 0
	STDOUT equ 1
	STDERR equ 2
	ERR_CODE_OK equ 0

	HexStr: db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00",10
	HEX_LEN equ $-HexStr

	HexTable: db "0123456789ABCDEF"

section .text

	global _start

_start:
	nop

Read:
	mov rax, SYS_READ
	mov rdi, STDIN
	mov rsi, Buff
	mov rdx, BUFF_LEN
	syscall

	mov rbp, rax
	cmp rax, 0
	je Exit

	xor rax, rax

	mov rsi, Buff
	xor rcx, rcx

Scan:
	mov rdx, rcx
	lea rdx, [rdx*2+rdx]

	mov al, byte [rsi+rcx]
	mov bl, al

	and al, 0Fh
	mov al, byte [HexTable+rax]
	mov byte [HexStr+rdx+2], al

	shr bl, 4
	mov bl, byte [HexTable+rbx]
	mov byte [HexStr+rdx+1], bl

	inc rcx
	cmp rcx, rbp
	jne Scan

Write:
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, HexStr
	add rdx, 3
	syscall
	jmp Read

Exit:
	mov rax, SYS_EXIT
	mov rdi, ERR_CODE_OK
	syscall
