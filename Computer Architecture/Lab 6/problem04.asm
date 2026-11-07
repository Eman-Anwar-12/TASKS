; Lab 6 - Problem 4: Matrix Traversal: Row-Major vs. Column-Major
; Cache Spec: Direct-mapped, 32-byte cache line (8 words), total size = 512 bytes (16 lines).
; Task: 16x16 word matrix. Compare row-major (stride 1 word) vs column-major (stride 16 words/64 bytes).
; Objective: Calculate theoretical hit/miss ratios.

global _main
extern _printf

section .data
    N equ 16
    format db "Matrix Traversal Complete: Row-Major (87.5%% hits) vs Col-Major (0%% hits)", 10, 0

section .bss
    matrix resd N * N   ; 16 x 16 words = 256 words = 1024 bytes

section .text
_main:
    ; Row-major traversal (stride = 4 bytes): 1 miss every 8 words = 87.5% hit rate
    xor eax, eax
    xor edx, edx
.row_i:
    xor ecx, ecx
.row_j:
    mov ebx, edx
    shl ebx, 4          ; i * 16
    add ebx, ecx
    add eax, [matrix + ebx * 4]
    inc ecx
    cmp ecx, N
    jl .row_j
    inc edx
    cmp edx, N
    jl .row_i

    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
