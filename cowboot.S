; computer boots at real mode - declare 16 bits operation
bits 16

green_palette equ 0xA
black_palette equ 0x0

global _start

; both will be assigned via linker
extern _cow_len
extern _cow_start

section .text
_start:

_clear_screen:
    mov ah, 0x00 ; set video mode subfunction
    mov al, 0x03 ; text mode, 16 colors
    
    int 0x10

_set_black_bg_color:
    mov ah, 0x0b ; set color subfunction
    mov bh, 0 ; bg color
    mov bl, black_palette

    int 0x10

_write_cow:
    mov ax, 0x7c0 ; physical boot address
    mov es, ax

    mov bp, _cow_start ; string addr
    mov cx, _cow_len ; string len

    xor bh, bh ; page number 0
    xor dx, dx ; row / col 0
    mov al, 1 ; write mode - move cursor
    mov bl, green_palette ; green character color for cyber effect
    
    mov ah, 0x13 ; write string subfunction
    int 0x10

_loop:
    jmp $
