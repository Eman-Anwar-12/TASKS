; Lab 5 - Task 8: Direct-Mapped Cache Conflict Thrashing
; Part 2: Cache Mapping & Addressing Schemes
; Objective: Induce continuous conflict misses (ping-pong thrashing) in direct-mapped structure.
; Specification: Direct-mapped cache C = 8 KB. P1 and P2 have identical Set Index but different Tags.
; Alternating loads produce 100% miss rate despite working set (8 bytes) << 8 KB.

global _main
extern _printf

section .data
    iterations equ 2000
    format db "Conflict Thrashing completed: 2000 ping-pong loads executed (100%% miss rate)", 10, 0

section .bss
    align 4096
    arena resb 32768    ; Large memory arena

section .text
_main:
    ; P1 and P2 mapped to same set index with delta = 8192 bytes (cache capacity)
    lea esi, [arena]            ; P1
    lea edi, [arena + 8192]     ; P2: identical lower 13 bits (set index), different tag
    mov ecx, iterations

.ping_pong_loop:
    ; P1 loads: evicts P2 from Set K
    mov eax, [esi]
    ; P2 loads: evicts P1 from Set K
    mov ebx, [edi]
    dec ecx
    jnz .ping_pong_loop

    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
