; Lab 6 - Problem 5: Software Direct-Mapped Cache Simulator (Bit Masking)
; Cache Spec: Direct-mapped, 4 lines, 16 bytes/line (total 64 bytes).
; Task: cache_lookup(address) maintaining tag store in memory.
; Bit fields:
; - Block Offset: bits [3:0]
; - Set Index: bits [5:4] (2 bits = 4 sets)
; - Tag: bits [31:6] (26 bits)
; Returns: EAX = 1 (HIT), EAX = 0 (MISS).

global _main
extern _printf

section .data
    sim_valid db 0, 0, 0, 0
    sim_tags  dd 0, 0, 0, 0
    test_addr dd 0x00000054
    format db "Lookup Address 0x%08X: Status = %s", 10, 0
    hit_str  db "HIT", 0
    miss_str db "MISS", 0

section .text
cache_lookup:
    ; Input address in EAX
    mov edx, eax
    shr edx, 6          ; EDX = Tag (bits 31:6)

    mov ecx, eax
    shr ecx, 4
    and ecx, 0x03       ; ECX = Set Index (bits 5:4)

    ; Check valid bit
    cmp byte [sim_valid + ecx], 1
    jne .miss

    ; Check tag match
    cmp [sim_tags + ecx * 4], edx
    jne .miss

    ; Cache HIT
    mov eax, 1
    ret

.miss:
    ; Update line on miss
    mov byte [sim_valid + ecx], 1
    mov [sim_tags + ecx * 4], edx
    xor eax, eax
    ret

_main:
    mov eax, [test_addr]
    call cache_lookup

    cmp eax, 1
    je .print_hit
    push miss_str
    jmp .print_done
.print_hit:
    push hit_str
.print_done:
    push dword [test_addr]
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
