; Exe name: eatterm
; Version: 1.0
; Author: The guy from the assembly book
; Description: A simple program for Linux that demonstarted escape sequences to do a simple "fill-screen" text output.

section .data
	SCNWTH: equ 80
	PosTerm: db 27,"[01;[01H"
	POSLEN: equ $-PosTerm
	ClearTerm: db 27,"[2J"
	CLEARLEN: equ $-ClearTerm
	AdMsg: db "Eat at Joe's!"
	ADLEN: equ $-AdMsg
	Prompt: db "Press Enter: "
	PROMPTLEN: equ $-Prompt

	Digits: db "000102030405060708091011121314151617181920"
		db "212324252627282930313233343536373839404142"
		db "434445464748495051525354555657585960616263"
		db "6465666768697071727374757677787980"

section .bss

section .text

ClrScreen:
	push rax
	push rbx
	push rcx
	push rdx
	mov rcx, ClearTerm
	mov rdx, CLEARLEN
	call WriteString
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret

GotoXY:
	push rax
	push rbx
	push rcx
	push rdx
	push rsp
	push rbp
	push rsi
	push rdi
	xor rbx, rbx
	xor rcx, rcx
	mov bl, al
	mov cx, word [Digits+rbx+2]
	mov word [PosTerm+2], cx
	mov bl, ah
	mov cx, [Digits+rbx+2]
	mov word [PosTerm+5], cx
	mov rcx, PosTerm
	mov rdx, POSLEN
	call WriteString
	pop rdi
	pop rsi
	pop rbp
	pop rsp
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret

WriteChr:
	push rbx
	xor rbx, rbx
	mov bl, SCNWTH
	sub bl, dl
	shr bl, 1
	mov ah, bl
	call GotoXY
	call WriteString
	pop rbx
	ret

WriteString:
	push rax
	push rsi
	push rdi
	mov rax, 1
	mov rdi, 1
	mov rsi, rcx
	syscall
	pop rdi
	pop rsi
	pop rax
	ret

global _start

_start:
	nop

	call ClrScreen

	mov al, 12
	mov rcx, AdMsg
	mov rdx, ADLEN
	call WriteChr

	mov ax, 0117h
	call GotoXY

	mov rcx, Prompt
	mov rdx, PROMPTLEN
	call WriteString

	mov rax, 0
	mov rdi, 0
	mov rsi, rcx
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
