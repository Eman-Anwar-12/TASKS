; Lab 6 - Problem 14: First-In, First-Out (FIFO) Replacement Queue
; Cache Spec: Fully associative, 4 lines.
; Task: Replacement using circular pointer/index (modulo 4) stored in register.
; On every miss: evict slot at ptr, ptr = (ptr + 1) & 0x03.
; Test sequence: {A, B, C, D, E, A, B, C, D, E}.

global _main
extern _printf

section .data
    fifo_tags dd 0, 0, 0, 0
    fifo_ptr  dd 0
    format db "FIFO Circular Queue Replacement: New miss evicts slot %d, next ptr = %d", 10, 0

section .text
_main:
    mov edx, [fifo_ptr] ; Current victim slot
    mov eax, edx
    inc eax
    and eax, 0x03       ; Next pointer modulo 4
    mov [fifo_ptr], eax

    push eax
    push edx
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
