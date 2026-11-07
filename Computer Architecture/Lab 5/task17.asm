; Lab 5 - Task 17: Software Data Prefetching Optimization
; Part 4: Hardware Discovery & Measurement
; Objective: Hide memory fetch latencies by interleaving explicit prefetch instructions with computation.
; Specification: Vector reduction loop with prefetcht0 scheduled K elements ahead (K in {2, 8, 32, 64}).

global _main
extern _printf

section .data
    N equ 16384
    K equ 32            ; Optimal prefetch distance
    format db "Prefetched Vector Reduction (Lead Distance K = %d): Sum = %d", 10, 0

section .bss
    vec resd N

section .text
_main:
    xor eax, eax        ; Sum accumulator
    xor ecx, ecx        ; Index i

.prefetch_loop:
    ; Prefetch cache line ahead by K elements into L1 cache
    prefetcht0 [vec + (ecx + K) * 4]

    ; Compute on current element
    add eax, [vec + ecx * 4]
    inc ecx
    cmp ecx, N - K
    jl .prefetch_loop

.drain_loop:
    add eax, [vec + ecx * 4]
    inc ecx
    cmp ecx, N
    jl .drain_loop

    push eax
    push K
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
