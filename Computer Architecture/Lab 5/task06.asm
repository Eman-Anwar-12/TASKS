; Lab 5 - Task 6: Structure of Arrays (SoA) vs. Array of Structures (AoS)
; Part 1: Principle of Locality
; Objective: Evaluate memory bandwidth utilization and effective spatial locality.
; Specification: Entities {x: int32, y: int32, tag: int8, z: int32} (padded to 16 bytes in AoS).
; Sum only attribute x over 10,000 entities.

global _main
extern _printf

section .data
    NUM_ENTITIES equ 10000
    format db "AoS Sum = %d | SoA Sum = %d", 10, 0

section .bss
    ; AoS: each entity is 16 bytes: [x:4, y:4, tag:1, pad:3, z:4]
    aos_entities resb NUM_ENTITIES * 16
    ; SoA: contiguous arrays for each field
    soa_x resd NUM_ENTITIES

section .text
_main:
    ; Traversal 1: AoS (Line utilization = 4 / 16 = 25%)
    xor eax, eax        ; sum_aos
    xor ecx, ecx        ; i
.aos_loop:
    add eax, [aos_entities + ecx * 16]   ; offset of x is 0
    inc ecx
    cmp ecx, NUM_ENTITIES
    jl .aos_loop

    ; Traversal 2: SoA (Line utilization = 100%, 16 elements per 64-byte line)
    xor edx, edx        ; sum_soa
    xor ecx, ecx        ; i
.soa_loop:
    add edx, [soa_x + ecx * 4]
    inc ecx
    cmp ecx, NUM_ENTITIES
    jl .soa_loop

    push edx
    push eax
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
