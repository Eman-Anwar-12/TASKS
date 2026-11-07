; Lab 6 - Problem 17: Cache Invalidation and Maintenance Routines
; Cache Spec: Fully associative, 16 lines.
; Task:
; - cache_invalidate_all: clears all valid and dirty bits.
; - cache_invalidate_addr(reg_addr): searches tags and invalidates only matching line.

global _main
extern _printf

section .data
    inv_valid db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    inv_dirty db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    inv_tags  dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    format db "Cache Invalidation: Address 0x%08X line successfully invalidated", 10, 0

section .text
cache_invalidate_all:
    xor ecx, ecx
.clear_loop:
    mov byte [inv_valid + ecx], 0
    mov byte [inv_dirty + ecx], 0
    inc ecx
    cmp ecx, 16
    jl .clear_loop
    ret

cache_invalidate_addr:
    ; Input address in EAX
    mov edx, eax
    shr edx, 4          ; Tag
    xor ecx, ecx
.search_inv:
    cmp byte [inv_valid + ecx], 1
    jne .skip
    cmp [inv_tags + ecx * 4], edx
    jne .skip
    mov byte [inv_valid + ecx], 0
    mov byte [inv_dirty + ecx], 0
    ret
.skip:
    inc ecx
    cmp ecx, 16
    jl .search_inv
    ret

_main:
    mov eax, 0x00000050 ; Matches Tag 5
    call cache_invalidate_addr

    push 0x00000050
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
