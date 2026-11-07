; Lab 6 - Problem 11: Tag Comparison Engine (Linear Search)
; Cache Spec: Fully associative, 8 lines, 16 bytes/line.
; Task: Maintain 8 tag entries. Given input address:
; - Extract Tag = bits [31:4]
; - Sequentially loop through all 8 entries to evaluate hit or miss.

global _main
extern _printf

section .data
    fa_tags  dd 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70, 0x80
    fa_valid db 1, 1, 1, 1, 1, 1, 1, 1
    search_addr dd 0x00000405
    format db "Fully Associative Linear Search for Addr 0x%08X: %s", 10, 0
    str_hit  db "CACHE HIT", 0
    str_miss db "CACHE MISS", 0

section .text
_main:
    mov eax, [search_addr]
    shr eax, 4          ; Tag = bits [31:4] (0x40)

    xor ecx, ecx        ; Slot index = 0
.search_loop:
    cmp byte [fa_valid + ecx], 1
    jne .next_slot
    cmp eax, [fa_tags + ecx * 4]
    je .hit_found
.next_slot:
    inc ecx
    cmp ecx, 8
    jl .search_loop

    ; Miss
    push str_miss
    jmp .print_res
.hit_found:
    push str_hit
.print_res:
    push dword [search_addr]
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
