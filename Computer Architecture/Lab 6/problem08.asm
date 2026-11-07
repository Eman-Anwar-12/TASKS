; Lab 6 - Problem 8: Instruction Cache Thrashing via Branch Bouncing
; Cache Spec: Direct-mapped L1 Instruction Cache (512 bytes).
; Task: Position FuncA and FuncB in .text such that entry points map to same cache set.
; Objective: Loop alternating calls between them causing continuous I-cache evictions.

global _main
extern _printf

section .data
    format db "Instruction Cache Bouncing completed: FuncA/FuncB alternating calls executed", 10, 0

section .text
align 512
FuncA:
    nop
    ret

align 512
FuncB:
    nop
    ret

_main:
    mov ecx, 1000

.bounce_loop:
    call FuncA         ; Loads cache line for FuncA (evicts FuncB)
    call FuncB         ; Loads cache line for FuncB (evicts FuncA)
    dec ecx
    jnz .bounce_loop

    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
