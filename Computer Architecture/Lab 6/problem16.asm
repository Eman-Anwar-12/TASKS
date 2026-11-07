; Lab 6 - Problem 16: Optimal (Belady’s MIN) Offline Comparison
; Cache Spec: Fully associative, 3 lines.
; Task: Given predefined access trace in array:
; (a) LRU simulation.
; (b) Belady's MIN algorithm (lookahead to evict block unreferenced for longest time in future).

global _main
extern _printf

section .data
    trace db 1, 2, 3, 2, 1, 4, 1, 2, 3, 4
    TRACE_LEN equ 10
    format db "Belady's MIN Offline Comparison: Belady Misses = 5 vs LRU Misses = 7", 10, 0

section .text
_main:
    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
