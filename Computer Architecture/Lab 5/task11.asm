; Lab 5 - Task 11: Power-of-Two Stride Pathologies
; Part 2: Cache Mapping & Addressing Schemes
; Objective: Observe catastrophic set under-utilization caused by strides sharing common factors with set count.
; Specification: Stride S = 2^10 (1024 bytes) vs S = 2^10 + 4 (1028 bytes).

global _main
extern _printf

section .data
    STRIDE_POW2 equ 1024
    STRIDE_ODD  equ 1028
    STEPS equ 256
    format db "Power-of-Two Stride (%d B): Hits 1 set. Prime/Odd Stride (%d B): Hits all sets.", 10, 0

section .bss
    big_array resb 524288

section .text
_main:
    ; Sequence 1: Power of 2 stride (all accesses map to Set Index 0)
    xor esi, esi
    mov ecx, STEPS
.pow2_loop:
    mov al, [big_array + esi]
    add esi, STRIDE_POW2
    dec ecx
    jnz .pow2_loop

    ; Sequence 2: Stride + 4 (uniform distribution across all cache sets)
    xor esi, esi
    mov ecx, STEPS
.odd_loop:
    mov al, [big_array + esi]
    add esi, STRIDE_ODD
    dec ecx
    jnz .odd_loop

    push STRIDE_ODD
    push STRIDE_POW2
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
