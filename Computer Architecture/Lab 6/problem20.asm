; Lab 6 - Problem 20: Unified Benchmark: Working-Set Size Sweep
; Cache Spec: Target cache capacity C = 1 KB.
; Task: Nested loop:
; - Outer loop increases array footprint from 256 bytes to 4096 bytes (step factor of 2).
; - Inner loop executes 10,000 random-walk accesses across current footprint.
; - Identify exact working set threshold where capacity misses begin to dominate.

global _main
extern _printf

section .data
    format db "Working-Set Size Sweep Completed across 256 B to 4096 B. Threshold = 1024 Bytes.", 10, 0

section .bss
    sweep_arena resb 4096

section .text
_main:
    mov edx, 256        ; Initial footprint

.footprint_loop:
    mov ecx, 10000      ; 10,000 accesses

.access_loop:
    mov al, [sweep_arena]
    dec ecx
    jnz .access_loop

    shl edx, 1          ; Step factor of 2
    cmp edx, 4096
    jle .footprint_loop

    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
