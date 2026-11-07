; Lab 5 - Task 5: Loop Tiling (Blocking) for Spatial and Temporal Reuse
; Part 1: Principle of Locality
; Objective: Optimize multidimensional access patterns by confining sub-problems to L1 cache.
; Specification: Out-of-place matrix transposition (B = A^T) with T x T tiles.
; Condition: 2 * T^2 * sizeof(element) <= C_L1

global _main
extern _printf

section .data
    N equ 256
    T equ 16            ; Tile dimension: 2 * 16^2 * 4 = 2048 bytes (fits in L1)
    format db "Tiled Matrix Transpose completed successfully (Tile size = %d)", 10, 0

section .bss
    matA resd N * N
    matB resd N * N

section .text
_main:
    ; 4-nested loops: ii, jj, i, j
    xor edi, edi        ; ii = 0 (Tile row)
.tile_row:
    xor esi, esi        ; jj = 0 (Tile col)
.tile_col:

    ; Inside Tile: i from ii to ii + T
    mov edx, edi
.inner_i:
    mov ecx, esi
.inner_j:
    ; Read A[i][j]: index = i * N + j
    mov eax, edx
    shl eax, 8
    add eax, ecx
    mov ebx, [matA + eax * 4]

    ; Write B[j][i]: index = j * N + i
    mov eax, ecx
    shl eax, 8
    add eax, edx
    mov [matB + eax * 4], ebx

    inc ecx
    mov eax, esi
    add eax, T
    cmp ecx, eax
    jl .inner_j

    inc edx
    mov eax, edi
    add eax, T
    cmp edx, eax
    jl .inner_i

    add esi, T
    cmp esi, N
    jl .tile_col

    add edi, T
    cmp edi, N
    jl .tile_row

    push T
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
