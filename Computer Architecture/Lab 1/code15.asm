; Task 15: Exchange Two Registers
; Put 10 into AL. Put 20 into BL. Exchange their values.

global _main
extern _printf

section .data
    format db "AL = %d, BL = %d", 10, 0

section .text
_main:
    mov al, 10
    mov bl, 20

    ; Swap AL and BL
    xchg al, bl

    ; AL is now 20, BL is now 10
    movzx ecx, bl
    movzx eax, al

    push ecx
    push eax
    push format
    call _printf

    add esp, 12

    xor eax, eax
    ret
