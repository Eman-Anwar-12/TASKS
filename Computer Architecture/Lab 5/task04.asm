; Lab 5 - Task 4: Row-Major vs. Column-Major Matrix Traversal
; Part 1: Principle of Locality
; Objective: Quantify performance divergence between cache-friendly and cache-hostile nested loops.
; Specification: 256 x 256 integer matrix. Row-major vs Column-major sweeps.

global _main
extern _printf

section .data
    N equ 256
    format db "Row-major Sum = %d, Column-major Sum = %d", 10, 0

section .bss
    matrix resd N * N   ; 256 x 256 32-bit integers (256 KB)

section .text
_main:
    ; --- Routine 1: Row-Major Sweep (Cache-Friendly: Stride = 4 bytes) ---
    xor eax, eax        ; Accumulator sum_row
    xor edx, edx        ; Outer loop index i (rows)
.row_outer:
    xor ecx, ecx        ; Inner loop index j (cols)
.row_inner:
    ; Offset = (i * 256 + j) * 4
    mov ebx, edx
    shl ebx, 8          ; i * 256
    add ebx, ecx        ; + j
    add eax, [matrix + ebx * 4]
    inc ecx
    cmp ecx, N
    jl .row_inner
    inc edx
    cmp edx, N
    jl .row_outer

    ; --- Routine 2: Column-Major Sweep (Cache-Hostile: Stride = 1024 bytes) ---
    xor esi, esi        ; Accumulator sum_col
    xor ecx, ecx        ; Outer loop index j (cols)
.col_outer:
    xor edx, edx        ; Inner loop index i (rows)
.col_inner:
    ; Offset = (i * 256 + j) * 4
    mov ebx, edx
    shl ebx, 8
    add ebx, ecx
    add esi, [matrix + ebx * 4]
    inc edx
    cmp edx, N
    jl .col_inner
    inc ecx
    cmp ecx, N
    jl .col_outer

    push esi
    push eax
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
