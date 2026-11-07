; Lab 6 - Problem 15: Pseudo-Random Replacement Policy (LFSR Implementation)
; Cache Spec: Fully associative, 8 lines.
; Task: 8-bit Galois Linear Feedback Shift Register (LFSR) in assembly.
; On miss with all slots full, use LFSR_val (mod 8) to select victim block.

global _main
extern _printf

section .data
    lfsr_state db 0x5A  ; Non-zero seed
    format db "LFSR Pseudo-Random State = 0x%02X -> Victim Slot = %d", 10, 0

section .text
lfsr_next:
    mov al, [lfsr_state]
    mov bl, al
    shr bl, 1
    test al, 1
    jz .no_xor
    xor bl, 0xB4        ; Polynomial mask (x^8 + x^6 + x^5 + x^4 + 1)
.no_xor:
    mov [lfsr_state], bl
    movzx eax, bl
    ret

_main:
    call lfsr_next
    mov ecx, eax
    and ecx, 0x07       ; mod 8 for victim slot

    push ecx
    push eax
    push format
    call _printf
    add esp, 12

    xor eax, eax
    ret
