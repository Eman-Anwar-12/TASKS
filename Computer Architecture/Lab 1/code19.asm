; Task 19: Use the Stack
; Put hexadecimal 12345678 into EAX. Push it onto the stack.
; Pop it into EBX. Display both registers.

global _main
extern _printf

section .data
    format db "EAX = 0x%08X, EBX = 0x%08X", 10, 0

section .text
_main:
    mov eax, 0x12345678

    ; Push EAX onto stack
    push eax

    ; Pop top value into EBX
    pop ebx

    push ebx
    push eax
    push format
    call _printf

    add esp, 12

    xor eax, eax
    ret
