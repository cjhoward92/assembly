section .data

	MyName db "Carson Howard",10
	MyNameLength equ $-MyName
	Exit equ 60
	ExitCode equ 0
	SysWrite equ 1
	StdOut equ 1

section .bss

section .text

global _start

_start:
	mov rax, SysWrite		; calling sys_write
	mov rdi, StdOut			; calling the stdout fd
	mov rsi, MyName			; printing MyName
	mov rdx, MyNameLength		; The string is length of MyName
	syscall

	mov rax, Exit			; set the next syscall to exit
	mov rdi, ExitCode		; set the error code to 0
	syscall				; exit the program
