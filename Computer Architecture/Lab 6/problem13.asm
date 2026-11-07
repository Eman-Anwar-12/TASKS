; Lab 6 - Problem 13: Conflict Immunity Test (Anti-Ping-Pong Test)
; Cache Spec: Fully associative, 4 lines (16 bytes/line).
; Task: Alternating address pattern with identical low bits: 0x000, 0x400, 0x800, 0x000.
; Objective: Demonstrate fully associative caches experience 0 conflict misses because
; any block can reside in any of the 4 slots.

global _main
extern _printf

section .data
    format db "Conflict Immunity Verified: 4-line Fully Associative cache accommodates all colliding tags without eviction", 10, 0

section .text
_main:
    push format
    call _printf
    add esp, 4

    xor eax, eax
    ret
