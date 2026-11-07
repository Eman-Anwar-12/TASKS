; Lab 5 - Task 7: Address Bit-Field Extraction (Tag, Set Index, Block Offset)
; Part 2: Cache Mapping & Addressing Schemes
; Objective: Implement internal hardware decoder logic mapping physical address to cache sets and tags.
; Specification: 32-bit architecture, 4 KB direct-mapped cache, 32-byte block size (B=32, S=128).
; Outputs:
; - Block Offset: bits [4:0] (5 bits)
; - Set Index: bits [11:5] (7 bits)
; - Tag: bits [31:12] (20 bits)

global _main
extern _printf

section .data
    test_addr dd 0x80001FE0
    format db "Address: 0x%08X -> Tag: 0x%05X, Set Index: 0x%02X, Offset: 0x%02X", 10, 0

section .text
_main:
    mov eax, [test_addr] ; Input address in EAX (r0)

    ; Extract Block Offset (bits 4:0) into r1 (EBX)
    mov ebx, eax
    and ebx, 0x1F       ; 5-bit mask (0001 1111b)

    ; Extract Set Index (bits 11:5) into r2 (ECX)
    mov ecx, eax
    shr ecx, 5          ; Shift down 5 bits
    and ecx, 0x7F       ; 7-bit mask (128 sets = 0..127)

    ; Extract Tag (bits 31:12) into r3 (EDX)
    mov edx, eax
    shr edx, 12         ; Shift down 12 bits

    push ebx            ; Offset
    push ecx            ; Set Index
    push edx            ; Tag
    push dword [test_addr]
    push format
    call _printf
    add esp, 20

    xor eax, eax
    ret
