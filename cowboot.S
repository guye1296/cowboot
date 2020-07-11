global _start

green_palette equ 0xA

section .data
    
; computer boots at real mode - declare 16 bits operation
bits 16

section .text
_start:
    nop
