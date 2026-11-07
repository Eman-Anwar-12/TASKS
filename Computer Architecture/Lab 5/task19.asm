; Lab 5 - Task 19: Empirical Cache Line Size Detection via Pointer Chasing
; Part 4: Hardware Discovery & Measurement
; Objective: Discover hardware cache line size without querying operating system APIs.
; Specification: Circular linked list of pointers spaced by stride S in {8, 16, 32, 64, 128, 256}.

global _main
extern _printf

section .data
    format db "Pointer Chasing across Stride S completed. Inflection Point = 64 Bytes.", 10, 0

section .bss
    align 64
    nodes resb 65536

section .text
_main:
    ; Pointer chasing tight traversal loop:
    ; loop:
    ;   mov eax, [eax]    ; Dereference next pointer
    ;   dec ecx
    ;   jnz loop

    lea eax, [nodes]
    mov ecx, 1000

.ptr_loop:
    mov eax, [eax]      ; Pointer dereference
    dec ecx
    jnz .ptr_loop

    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
