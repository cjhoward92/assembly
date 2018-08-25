section .data
section .bss
section .text
global _start

_start:
	mov eax, 447	; mov into eax
	mov ebx, 1739	; mov into ebx
	mul ebx		; multiply eax by ebx

	nop

	mov eax, 0FFFFFFFFh
	mov ebx, 03b72h
	mul ebx

	nop
