section .bss
	Buff resb 1024			; Create a buffer of length 1024 bytes

section .data
	SYS_READ equ 0
	STDIN equ 0
	STDOUT equ 1
	SYS_EXIT equ 60
	SYS_WRITE equ 1
	BUF_LEN equ 1024
	
section .text
	global _start

_start:
	nop

Read:	mov rax, SYS_READ		; READ syscall
	mov rdi, STDIN			; Reading from STDIN
	mov rsi, Buff			; Put the buffer into rsi
	mov rdx, BUF_LEN		; Take a single character from stdin and put it in the buffer
	syscall

	cmp rax, 0			; See if the return value is 0, and if so exit
	je Exit

	mov rbp, Buff			; mov the address of Buff to rbp
	dec rbp				; decrement rbp so we can use the count as the offset
	mov rcx, rax			; mov char count read to rcx

Loop:	cmp byte [rbp+rcx], 61h		; Test input against lowercase 'a'
	jb Dec				; If below 'a' in the ASCII table, it is not a lowercase character
	cmp byte [rbp+rcx], 7ah		; Test input against lowercase 'z'
	ja Dec				; If above 'a' in the ASCII table, it is not a lowercase character

	sub byte [rbp+rcx], 20h		; If the character is lowercase, uppwercase it by subtracting 32

Dec:	dec rcx				; Decrement rcx
	jnz Loop			; If not zero go to loop

Write:	mov rax, SYS_WRITE		; Get ready to call write
	mov rdi, STDOUT			; Write to stdout
	mov rsi, Buff			; Write the contents of the buffer
	mov rdx, BUF_LEN			; Write the buffer length
	syscall
	jmp Read			; Go back to Read

Exit:	mov rax, SYS_EXIT
	mov rdi, 0
	syscall
