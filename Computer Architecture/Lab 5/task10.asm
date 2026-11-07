; Lab 5 - Task 10: Fully Associative Software Emulation
; Part 2: Cache Mapping & Addressing Schemes
; Objective: Model content-addressable memory (CAM) parallel search logic in software assembly.
; Specification: 8-entry lookup array storing simulated cache tags and status bits.

global _main
extern _printf

section .data
    NUM_ENTRIES equ 8
    cam_tags dd 0x100, 0x200, 0x300, 0x400, 0x500, 0x600, 0x700, 0x800
    cam_valid db 1, 1, 1, 1, 1, 1, 1, 1
    input_tag dd 0x500
    msg_hit  db "CAM Search for Tag 0x%X: CACHE HIT at Entry %d", 10, 0
    msg_miss db "CAM Search for Tag 0x%X: CACHE MISS", 10, 0

section .text
_main:
    mov edx, [input_tag]
    xor ecx, ecx        ; Loop index i = 0

.cam_search:
    cmp byte [cam_valid + ecx], 1
    jne .next_entry
    cmp edx, [cam_tags + ecx * 4]
    je .found_hit

.next_entry:
    inc ecx
    cmp ecx, NUM_ENTRIES
    jl .cam_search

    ; MISS Handler
    push edx
    push msg_miss
    call _printf
    add esp, 8
    jmp .done

.found_hit:
    ; HIT Handler
    push ecx            ; Entry index
    push edx            ; Tag
    push msg_hit
    call _printf
    add esp, 12

.done:
    xor eax, eax
    ret
