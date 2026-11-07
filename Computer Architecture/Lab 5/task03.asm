; Lab 5 - Task 3: Strided Access Degradation
; Part 1: Principle of Locality
; Objective: Systematically quantify the destruction of spatial locality as stride interval increases.
; Specification: Parameterized traversal with variable byte stride S in {4, 16, 32, 64, 128}.
; Critical stride Scrit = 64 bytes (matching cache line size) where hit rate drops to 0%.

global _main
extern _printf

section .data
    BUF_SIZE equ 32768
    format db "Stride = %d bytes, Total Elements Visited = %d", 10, 0

section .bss
    buffer resb BUF_SIZE

section .text
_main:
    ; Benchmark across stride S = 64 (Scrit)
    mov edx, 64         ; Stride S = 64 bytes
    xor esi, esi        ; Byte offset = 0
    xor ecx, ecx        ; Access count

.stride_loop:
    ; Effective Address = Base + offset
    mov al, [buffer + esi]
    inc ecx
    add esi, edx
    cmp esi, BUF_SIZE
    jl .stride_loop

    push ecx
    push edx
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
