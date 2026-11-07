; Lab 5 - Task 2: Temporal Locality with Hot Working Sets
; Part 1: Principle of Locality
; Objective: Demonstrate zero-latency reuse when working sets fit completely within a single cache block.
; Specification: Allocate a single 16-byte aligned memory block. Execute 10,000 iterations of read-modify-write.

global _main
extern _printf

section .data
    align 16
    hot_var dd 0        ; 16-byte aligned single cache-resident word
    iterations equ 10000
    format db "Final Hot Variable Value = %d (Misses after cycle 1 = 0)", 10, 0

section .text
_main:
    mov ecx, iterations

.rmw_loop:
    ; Read-Modify-Write cycle
    ; Cycle 1: Cold compulsory cache miss brings block into L1 cache
    ; Cycles 2..10000: 100% temporal cache hit rate, 0 bus transactions
    mov eax, [hot_var]  ; Read (Cache Hit)
    inc eax             ; Modify in ALU
    mov [hot_var], eax  ; Write (Cache Hit, absorbed by L1 store buffer)
    dec ecx
    jnz .rmw_loop

    push dword [hot_var]
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
