; Lab 5 - Task 1: Spatial Locality via Contiguous Array Traversal
; Part 1: Principle of Locality
; Objective: Observe compulsory line fetches and consecutive hit rates on linear memory walks.
; Specification: Allocate a contiguous 1D array of N = 1024 32-bit integers.
; Calculate theoretical cache miss rate with 64-byte line: 64 / 1024 = 6.25%.

global _main
extern _printf

section .data
    N equ 1024
    format db "Array Sum = %d, Theoretical Miss Rate = 6.25%%", 10, 0

section .bss
    array resd N        ; Contiguous array of 1024 32-bit integers (4096 bytes)

section .text
_main:
    ; Initialize array base and loop parameters
    mov ecx, 0          ; Index i = 0
    xor eax, eax        ; Sum accumulator = 0

.sum_loop:
    ; Sequential linear walk exhibits high spatial locality.
    ; Each 64-byte cache line holds 16 integers (16 * 4 bytes).
    ; First access incurs compulsory miss; next 15 accesses hit in L1 cache.
    add eax, [array + ecx * 4]
    inc ecx
    cmp ecx, N
    jl .sum_loop

    push eax
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
