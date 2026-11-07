; Lab 5 - Task 12: Cache Index Hashing Emulation
; Part 2: Cache Mapping & Addressing Schemes
; Objective: Implement XOR-based set index randomization to mitigate regular conflict strides.
; Specification: Index_hashed = Index_raw XOR (Tag & Mask).

global _main
extern _printf

section .data
    raw_address dd 0x0040A420
    format db "Raw Address = 0x%08X -> Raw Set = 0x%02X, Hashed Set = 0x%02X", 10, 0

section .text
_main:
    mov eax, [raw_address]

    ; Extract Raw Set Index (bits 11:5)
    mov ebx, eax
    shr ebx, 5
    and ebx, 0x7F       ; Raw index

    ; Extract Tag (bits 31:12)
    mov ecx, eax
    shr ecx, 12

    ; Hash function: Index_hashed = Index_raw XOR (Tag & 0x7F)
    mov edx, ecx
    and edx, 0x7F       ; Tag & Mask
    xor edx, ebx        ; Index_hashed

    push edx            ; Hashed Index
    push ebx            ; Raw Index
    push eax            ; Address
    push format
    call _printf
    add esp, 16

    xor eax, eax
    ret
