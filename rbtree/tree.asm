; Definition of a node:
;	4 bytes for the key
;	4 bytes for color
;	8 bytes (address) for the parent
;	8 bytes (address) for the left
;	8 bytes (address) for the right
;	A value of 0 in an address represents NULL

section .bss
	node: resb 32

section .data
	CLR_OFT equ 4
	PAR_OFT equ 8
	LEFT_OFT equ 16
	RIGHT_OFT equ 24

section .text

GLOBAL AddNode

AddNode:
	
