; Task 14: Test Two Bit Patterns
; Put hexadecimal F0 into AL. Put hexadecimal 0F into BL.
; Use TEST to check whether they have any common 1 bits.

global _main
extern _printf

section .data
    zeroMessage db "No common 1 bits were found.", 10, 0
    commonMessage db "Common 1 bits were found.", 10, 0

section .text
_main:
    ; AL = 11110000b
    mov al, 0xF0

    ; BL = 00001111b
    mov bl, 0x0F

    ; TEST performs bitwise AND without storing result.
    test al, bl

    ; Jump if zero (ZF = 1)
    jz no_common_bits

common_bits:
    push commonMessage
    call _printf
    add esp, 4
    jmp finished

no_common_bits:
    push zeroMessage
    call _printf
    add esp, 4

finished:
    xor eax, eax
    ret
