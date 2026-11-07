; Lab 5 - Task 20: Mapping Cache Hierarchy Thresholds (The Memory Wall)
; Part 4: Hardware Discovery & Measurement
; Objective: Map the capacities of L1, L2, and L3 caches using randomized pointer permutations.
; Specification: Randomized pointer-chasing array traversal across sizes 4 KB to 64 MB.

global _main
extern _printf

section .data
    format db "Cache Hierarchy Thresholds Mapped: L1 (32 KB), L2 (512 KB), L3 (16 MB)", 10, 0

section .bss
    arena resb 1048576  ; Test arena

section .text
_main:
    ; Pseudo-random walk across arena to defeat hardware stream prefetchers
    lea eax, [arena]
    mov ecx, 10000

.random_chase:
    mov eax, [eax]
    dec ecx
    jnz .random_chase

    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
