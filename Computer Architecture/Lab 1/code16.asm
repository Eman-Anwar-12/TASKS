; Task 16: Store a Number in Memory
; Create a byte in memory and store decimal 42 inside it.

global _main
extern _printf

section .data
    number db 0
    format db "Value in memory = %d", 10, 0

section .text
_main:
    ; Store decimal 42 into memory variable
    mov byte [number], 42

    ; Read byte from memory
    movzx eax, byte [number]

    push eax
    push format
    call _printf

    add esp, 8

    xor eax, eax
    ret
