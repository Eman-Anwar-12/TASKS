; Lab 5 - Task 15: Write-Through vs. Write-Back Buffer Pressure
; Part 3: Replacement Policies and Write Mechanics
; Objective: Observe store buffer stalls and write-merge efficiency.
; Specification: 50,000 store instructions:
; 1. Continuous repeated stores to single cache-resident address.
; 2. Interspersed stores across dispersed uncached addresses.

global _main
extern _printf

section .data
    STORES equ 50000
    format db "Store Pressure Benchmark: 50,000 stores completed for resident vs dispersed targets", 10, 0

section .bss
    target_resident resd 1
    target_dispersed resd 50000

section .text
_main:
    ; Pattern 1: Cache-resident repeated stores (Absorbed by L1 dirty line in Write-Back)
    mov ecx, STORES
.wb_loop:
    mov [target_resident], ecx
    dec ecx
    jnz .wb_loop

    ; Pattern 2: Dispersed stores (Saturates store queue / bus FIFO in Write-Through)
    mov ecx, STORES
.wt_loop:
    mov [target_dispersed + ecx * 4 - 4], ecx
    dec ecx
    jnz .wt_loop

    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
