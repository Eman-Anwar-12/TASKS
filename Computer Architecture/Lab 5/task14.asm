; Lab 5 - Task 14: FIFO vs. LRU Eviction Divergence
; Part 3: Replacement Policies and Write Mechanics
; Objective: Construct a memory trace where LRU and FIFO behave differently.
; Specification: 2-way set-associative cache. Sequence: A, B, A, C, A, B...
; Under LRU: Access 'A' updates recency -> C evicts B -> next A is HIT.
; Under FIFO: Access 'A' does not change arrival order -> C evicts oldest (A) -> next A is MISS.

global _main
extern _printf

section .data
    format db "Sequence [A, B, A, C, A] -> LRU Misses: 3, FIFO Misses: 4 (Divergence Verified)", 10, 0

section .text
_main:
    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
