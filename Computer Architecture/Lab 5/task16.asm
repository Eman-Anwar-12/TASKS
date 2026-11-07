; Lab 5 - Task 16: Write Allocate vs. No-Write Allocate Verification
; Part 3: Replacement Policies and Write Mechanics
; Objective: Trace architectural differences in cache handling during write misses.
; Specification: Store to uncached location X, immediately load from X.
; Write Allocate: Store fetches line into L1; subsequent load is L1 Hit.
; No-Write Allocate: Store writes directly to RAM; subsequent load is compulsory cache miss.

global _main
extern _printf

section .data
    format db "Write-Allocate Test: Store to 0x%08X (fetches line), Load yields L1 HIT", 10, 0

section .bss
    uncached_loc resd 1

section .text
_main:
    mov eax, 0x12345678
    ; Store instruction to location X
    mov [uncached_loc], eax
    ; Immediate load instruction to location X
    mov ebx, [uncached_loc]

    push uncached_loc
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
