; Task 12: Perform an OR Operation
; Put 5 into AL and perform OR with 8.

global _main
extern _printf

section .data
    format db "Result = %d", 10, 0

section .text
_main:
    ; Decimal 5: 00000101b
    mov al, 5

    ; Decimal 8: 00001000b
    or al, 8

    ; Result: 00001101b = 13
    movzx eax, al

    push eax
    push format
    call _printf

    add esp, 8

    xor eax, eax
    ret
