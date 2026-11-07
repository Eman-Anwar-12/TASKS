; Lab 5 - Task 18: Cache Flushing and Cold-Start Latency Quantification
; Part 4: Hardware Discovery & Measurement
; Objective: Measure exact clock cycle penalties of cache misses using hardware timing instructions.
; Specification: RDTSC / RDTSCP to measure:
; 1. Load latency of hot, cache-resident address.
; 2. Load latency immediately following explicit cache flush (clflush).

global _main
extern _printf

section .data
    format db "Hot L1 Load Cycles: %d | Cold-Miss Load Cycles: %d", 10, 0

section .bss
    test_line resd 16

section .text
_main:
    ; Warm up cache line
    mov eax, [test_line]

    ; Measure Hot Hit Latency
    rdtsc
    mov esi, eax        ; Start cycle
    mov ebx, [test_line]; Hot read
    rdtsc
    sub eax, esi
    mov edi, eax        ; Hot delta cycles

    ; Explicitly invalidate / flush cache line from all cache levels
    clflush [test_line]
    mfence

    ; Measure Cold Miss Latency
    rdtsc
    mov esi, eax        ; Start cycle
    mov ebx, [test_line]; Cold read from DRAM
    rdtsc
    sub eax, esi
    mov edx, eax        ; Cold delta cycles

    push edx
    push edi
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
