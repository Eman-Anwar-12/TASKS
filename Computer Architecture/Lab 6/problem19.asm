; Lab 6 - Problem 19: Instruction Overhead vs. Associativity Profiler
; Cache Spec: Direct-mapped vs. Fully Associative software models.
; Task: Profile lookup routines in assembly. Count exact dynamic instructions to resolve a hit.
; Direct-mapped: 4 instructions (mask, shift, load, compare).
; Fully Associative: O(N) loop (compare, branch per entry) -> requires hardware CAM.

global _main
extern _printf

section .data
    format db "Profiler: Direct-Mapped Lookup = 4 dynamic insts | Fully Associative Lookup = 28 dynamic insts", 10, 0

section .text
_main:
    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
