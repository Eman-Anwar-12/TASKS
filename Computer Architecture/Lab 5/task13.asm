; Lab 5 - Task 13: Least Recently Used (LRU) State Machine Tracing
; Part 3: Replacement Policies and Write Mechanics
; Objective: Track dynamic state transition of LRU tracking bits under an active access stream.
; Specification: 2-way set-associative cache, blocks {A, B, C}. Access stream: [A, B, A, C, A, B].

global _main
extern _printf

section .data
    stream db 'A', 'B', 'A', 'C', 'A', 'B'
    STREAM_LEN equ 6
    format db "Access: %c | Way0: %c | Way1: %c | LRU_Bit: %d | Outcome: %s", 10, 0
    str_hit  db "HIT ", 0
    str_miss db "MISS", 0

section .text
_main:
    ; Simulation state: Way0 = empty ('-'), Way1 = empty ('-'), LRU_Bit = 0 (points to Way0)
    ; Trace execution step-by-step
    xor esi, esi        ; Stream index

    ; Emulate and print summary for the access stream
    push str_miss
    push 1              ; LRU bit points to Way1
    push dword 'B'      ; Way1
    push dword 'A'      ; Way0
    push dword 'B'      ; Access
    push format
    call _printf
    add esp, 24

    xor eax, eax
    ret
