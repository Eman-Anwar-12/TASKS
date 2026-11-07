; Lab 6 - Problem 7: Write-Through vs. Write-Back Flag Tracking
; Cache Spec: Direct-mapped, 8 blocks.
; Task: Maintain dirty bit array alongside tag and valid bits.
; Implement store_word(addr, val):
; - On miss, evict current occupant.
; - If evicted line is dirty, invoke simulated mem_writeback().

global _main
extern _printf

section .data
    wb_valid db 0, 0, 0, 0, 0, 0, 0, 0
    wb_dirty db 0, 0, 0, 0, 0, 0, 0, 0
    wb_tags  dd 0, 0, 0, 0, 0, 0, 0, 0
    bus_writes dd 0
    format db "Simulated Store Complete. Writeback Bus Transactions = %d", 10, 0

section .text
mem_writeback:
    inc dword [bus_writes]
    ret

store_word:
    ; EAX = address, EBX = value
    mov edx, eax
    shr edx, 7          ; Tag
    mov ecx, eax
    shr ecx, 4
    and ecx, 0x07       ; Set Index (0..7)

    ; Check if valid and tag mismatch (Eviction)
    cmp byte [wb_valid + ecx], 1
    jne .install
    cmp [wb_tags + ecx * 4], edx
    je .write_hit

    ; Eviction: if dirty, write back to RAM
    cmp byte [wb_dirty + ecx], 1
    jne .install
    call mem_writeback

.install:
    mov byte [wb_valid + ecx], 1
    mov [wb_tags + ecx * 4], edx

.write_hit:
    ; Mark dirty in Write-Back cache
    mov byte [wb_dirty + ecx], 1
    ret

_main:
    mov eax, 0x100
    mov ebx, 42
    call store_word

    ; Colliding store triggers eviction & writeback
    mov eax, 0x200
    mov ebx, 99
    call store_word

    push dword [bus_writes]
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
