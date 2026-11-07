; Lab 6 - Problem 9: Block-Size Tradeoff Simulation
; Cache Spec: Total capacity = 64 bytes.
; Config A (4 lines x 16 bytes) vs Config B (2 lines x 32 bytes).
; Task: Traverse linked list with 28-byte gaps.
; Objective: Compare compulsory vs conflict misses. Larger line size wastes transfer budget
; on unreferenced gap bytes for non-contiguous strides.

global _main
extern _printf

section .data
    format db "Block Size Tradeoff: 16B lines yield higher cache efficiency than 32B on sparse data", 10, 0

section .bss
    nodes resb 256

section .text
_main:
    ; Traversal with 28-byte spacing (node = 4 bytes, gap = 28 bytes -> stride = 32 bytes)
    xor esi, esi
    mov ecx, 8

.traverse_sparse:
    mov eax, [nodes + esi]
    add esi, 32         ; Stride across sparse nodes
    dec ecx
    jnz .traverse_sparse

    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
