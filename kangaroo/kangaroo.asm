section .data
	Kang db "KANGAROO"

section .bss
section .text
global _start

_start:
	nop 			; Do nothing

	mov ebx,Kang 		; Set rbx to Kang
	mov eax,8 		; Set rax to 8
Work:	add byte [ebx],32 	; Add 32 to the current value of the byte pointed at by rbx
	inc ebx 		; increment rbx to the next byte
	dec eax 		; decrement one from rax
	jnz Work 		; If rax = 0 then move on

	nop 			; Do nothing - then segfault
