; Lab 6 - Problem 2: Stride-Induced Conflict Misses (Ping-Pong Thrashing)
; Cache Spec: Direct-mapped, total capacity = 1 KB (64 blocks x 16 bytes).
; Task: Allocate ArrayA and ArrayB separated by exactly 1024 bytes (identical set index).
; Objective: Interleaved reads cause 100% miss rate due to mutual eviction.

global _main
extern _printf

section .data
    ITERATIONS equ 1000
    format db "Ping-Pong Thrashing: 1000 interleaved reads -> 100%% Conflict Miss Rate", 10, 0

section .bss
    align 16
    array_a resb 1024   ; Base at 0 mod 1024
    array_b resb 1024   ; Base at 1024 mod 1024 (Collides on Set 0)

section .text
_main:
    mov ecx, ITERATIONS

.thrash_loop:
    ; Read from ArrayA (evicts ArrayB from Set 0)
    mov al, [array_a]
    ; Read from ArrayB (evicts ArrayA from Set 0)
    mov bl, [array_b]
    dec ecx
    jnz .thrash_loop

    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
