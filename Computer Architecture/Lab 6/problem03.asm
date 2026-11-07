; Lab 6 - Problem 3: Loop Padding and Alignment Optimization
; Cache Spec: Direct-mapped, total capacity = 1 KB.
; Task: Modify Problem 2 by inserting a 64-byte dummy buffer between ArrayA and ArrayB.
; Objective: Shifting relative base address eliminates set-index collisions.

global _main
extern _printf

section .data
    ITERATIONS equ 1000
    format db "Padding Optimization: 64-byte pad separates sets -> 0 Conflict Misses", 10, 0

section .bss
    align 16
    array_a resb 1024   ; Maps to Set 0
    dummy_pad resb 64   ; Padding introduces 4-line phase shift
    array_b resb 1024   ; Maps to Set 4 (No collision with ArrayA!)

section .text
_main:
    mov ecx, ITERATIONS

.clean_loop:
    mov al, [array_a]   ; Hits Set 0
    mov bl, [array_b]   ; Hits Set 4 (independent cache line, no eviction)
    dec ecx
    jnz .clean_loop

    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
