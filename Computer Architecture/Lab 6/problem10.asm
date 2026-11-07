; Lab 6 - Problem 10: Loop Tiling (Blocking) for a 1D Filter
; Cache Spec: Direct-mapped, 256 bytes (16 lines x 16 bytes).
; Task: 3-tap moving average filter: Y[i] = (X[i-1] + X[i] + X[i+1]) / 3
; Over array larger than cache capacity (1024 bytes). Tiled/blocked traversal in assembly.

global _main
extern _printf

section .data
    N equ 256           ; 256 words = 1024 bytes
    TILE equ 32         ; Tile size = 32 words = 128 bytes (fits easily in 256B cache)
    format db "1D Tiled Moving Average Filter completed for %d elements", 10, 0

section .bss
    X resd N
    Y resd N

section .text
_main:
    xor esi, esi        ; Tile start index

.tile_loop:
    mov ecx, esi
    inc ecx             ; i = tile_start + 1

.filter_inner:
    ; Y[i] = (X[i-1] + X[i] + X[i+1]) / 3
    mov eax, [X + ecx * 4 - 4]
    add eax, [X + ecx * 4]
    add eax, [X + ecx * 4 + 4]
    mov edx, 0
    mov ebx, 3
    div ebx
    mov [Y + ecx * 4], eax

    inc ecx
    mov edx, esi
    add edx, TILE - 1
    cmp ecx, edx
    jl .filter_inner

    add esi, TILE
    cmp esi, N - TILE
    jl .tile_loop

    push N
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
