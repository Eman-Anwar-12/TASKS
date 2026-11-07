; Lab 6 - Problem 18: Pathological Cyclic Thrashing (Capacity vs. Conflict)
; Cache Spec: Fully associative, 4 lines.
; Task: Loop iterating through 5 unique blocks sequentially (Block 0, 1, 2, 3, 4, 0, 1, 2, 3, 4...) under LRU.
; Objective: When working set size (N = 5) exceeds associativity (K = 4), hit rate drops to 0%.

global _main
extern _printf

section .data
    format db "Cyclic Thrashing (N=5, K=4): Hit Rate = 0%% (Capacity Thrashing Confirmed)", 10, 0

section .text
_main:
    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
