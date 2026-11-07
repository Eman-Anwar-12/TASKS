; Task 18: Add a Register Value to Memory
; Store 10 in memory. Put 5 into BL. Add BL to the value stored in memory.

global _main
extern _printf

section .data
    number db 10
    format db "New memory value = %d", 10, 0

section .text
_main:
    mov bl, 5

    ; Add BL to memory variable (read-modify-write)
    add byte [number], bl

    ; Read updated value
    movzx eax, byte [number]

    push eax
    push format
    call _printf

    add esp, 8

    xor eax, eax
    ret
