section .bss
	COLS	equ 81
	ROWS  	equ 25
	VidBuff	resb COLS*ROWS

section .data
	EOL	equ 10
	FILLCHR equ 32
	HBARCHR equ 196
	STRTROW equ 2

	Dataset db 9,71.17,52,55,18,29,36,18,68,77,63,58,44,0

	Message db "Data current as of 03/12/2018"
	MSGLEN	equ $-Message
	
	ClrHome	db 27,"[2J",27,"[01;01H"
	CLRLEN	equ $-ClrHome

	STDOUT	equ 1
	SYS_WRT	equ 1

section .text

GLOBAL _start

%macro pushaq 0
	push rax
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	push rsp
	push rbp
%endmacro

%macro popaq 0
	pop rbp
	pop rsp
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	pop rax
%endmacro

%macro SysWrite 2
	pushaq	
	mov rax, SYS_WRT
	mov rdi, STDOUT
	mov rsi, %1
	mov rdx, %2
	syscall
	popaq
%endmacro

%macro ClearHome 0
	SysWrite ClrHome,CLRLEN
%endmacro

Show:	pushaq
	SysWrite VidBuff,COLS*ROWS
	popaq
	ret

ClrVid:	push rax
	push rcx
	push rdi
	cld		; Clear DF, we're counting up-memory
	mov al, FILLCHR
	mov rdi, VidBuff
	mov rcx, COLS*ROWS
	rep stosb
	mov rdi, VidBuff
	dec rdi
	mov rcx, ROWS
PtEOL:	add rdi, COLS
	mov byte [rdi], EOL
	loop PtEOL
	pop rdi
	pop rcx
	pop rax
	ret

WrtLn:	push rax
	push rbx
	push rcx
	push rdi
	cld
	mov rdi, VidBuff
	dec rax
	dec rbx
	mov ah, COLS
	mul ah
	add rdi, rax
	add rdi, rbx
	rep movsb
	pop rdi
	pop rcx
	pop rbx
	pop rax
	ret

WrtHB:	push rax
	push rbx
	push rcx
	push rdi
	cld
	mov rdi, VidBuff
	dec rax
	dec rbx
	mov ah, COLS
	mul ah
	add rdi, rax
	add rdi, rbx
	mov al, HBARCHR
	rep stosb
	pop rdi
	pop rcx
	pop rbx
	pop rax
	ret

Ruler: 	push rax
	push rbx
	push rcx
	push rdi
	mov rdi, VidBuff
	dec rax
	dec rbx
	mov ah, COLS
	mul ah
	add rdi, rax
	add rdi, rbx
	mov rcx, 9
	mov al, '1'
DoChar:	stosb
	add al, 1h
	loop DoChar
	pop rdi
	pop rcx
	pop rbx
	pop rax
	ret

_start:	nop

	ClearHome
	call ClrVid

	mov rax, 1
	mov rbx, 1
	mov rcx, COLS-1
	call Ruler

	mov rsi, Dataset
	mov rbx, 1
	mov rbp, 0
.blast: mov rax, rbp
	add rax, STRTROW
	mov cl, byte [rsi+rbp]
	cmp rcx, 0
	je .rule2
	call WrtHB
	inc rbp
	jmp .blast

.rule2: mov rax, rbp
	add rax, STRTROW
	mov rbx, 1
	mov rcx, COLS-1
	call Ruler

	mov rsi, Message
	mov rcx, MSGLEN
	mov rbx, COLS
	sub rbx, rcx
	shr rbx, 1
	mov rax, 24
	call WrtLn

	call Show

Exit:	mov rax, 60
	mov rdi, 0
	syscall
