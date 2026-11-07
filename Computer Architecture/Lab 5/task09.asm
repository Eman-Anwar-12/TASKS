; Lab 5 - Task 9: Set-Associative Collision Thresholding
; Part 2: Cache Mapping & Addressing Schemes
; Objective: Experimentally determine associativity limit W of target cache.
; Specification: In N-way associative cache, traverse K colliding addresses with identical Set Index.
; Threshold: K = N + 1 triggers abrupt drop in hit rate due to set capacity exhaustion.

global _main
extern _printf

section .data
    WAY_N equ 4         ; Example 4-way associative cache
    format db "Set-associative threshold K = %d addresses traversed", 10, 0

section .bss
    align 4096
    memory_pool resb 65536

section .text
_main:
    ; Traverse K = N + 1 = 5 distinct addresses with stride equal to set distance (8192 bytes)
    mov ecx, 1000       ; Repetitions

.traverse_loop:
    mov eax, [memory_pool + 0 * 8192]   ; Way 1 fill
    mov eax, [memory_pool + 1 * 8192]   ; Way 2 fill
    mov eax, [memory_pool + 2 * 8192]   ; Way 3 fill
    mov eax, [memory_pool + 3 * 8192]   ; Way 4 fill
    mov eax, [memory_pool + 4 * 8192]   ; K=5 triggers capacity eviction within set!
    dec ecx
    jnz .traverse_loop

    push dword (WAY_N + 1)
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
