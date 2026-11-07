; Task 9: Increment a Register
; Put 9 into EAX and increase it by 1.

global _main
extern _printf

section .data
    format db "After INC, EAX = %d", 10, 0

section .text
_main:
    ; Start with 9.
    mov eax, 9

    ; INC means increase by one.
    inc eax

    ; EAX now contains 10.
    push eax
    push format
    call _printf

    add esp, 8

    xor eax, eax
    ret
