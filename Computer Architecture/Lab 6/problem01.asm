; Lab 6 - Problem 1: Single-Line Spatial Locality & Cold Misses
; Cache Spec: Direct-mapped, 16-byte block size (4 words per line).
; Task: Allocate 16-word array in .data. Iterate through words 0 to 3.
; Objective: Accessing word 0 causes cold miss; words 1-3 result in cache hits.

global _main
extern _printf

section .data
    array dd 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160
    format db "Sum of line elements [0..3] = %d (1 Cold Miss, 3 Hits)", 10, 0

section .text
_main:
    xor eax, eax        ; Sum accumulator
    xor ecx, ecx        ; Index i = 0

.walk_line:
    ; Word 0: Compulsory cache line fetch (brings 16 bytes: words 0, 1, 2, 3)
    ; Words 1..3: Spatial locality hits
    add eax, [array + ecx * 4]
    inc ecx
    cmp ecx, 4
    jl .walk_line

    push eax
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
