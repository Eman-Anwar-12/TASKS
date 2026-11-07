; Lab 6 - Problem 6: Power-of-Two Stride Degradation
; Cache Spec: Direct-mapped, 128 bytes total, 16-byte block size (8 sets).
; Task: Access 512-byte buffer using strides (16, 32, 64, 128 bytes).
; Objective: Strides that are multiples of total cache capacity (128 bytes)
; map to the exact same set index, degrading effective capacity to 1 block.

global _main
extern _printf

section .data
    BUF_LEN equ 512
    format db "Power-of-Two Stride Traversal Complete (Stride = %d bytes)", 10, 0

section .bss
    buffer resb BUF_LEN

section .text
_main:
    ; Stride = 128 bytes: access offsets 0, 128, 256, 384 all map to Set 0!
    mov edx, 128        ; Stride
    xor esi, esi        ; Offset
    mov ecx, 4          ; 512 / 128 = 4 accesses

.stride_loop:
    mov al, [buffer + esi]
    add esi, edx
    dec ecx
    jnz .stride_loop

    push edx
    push format
    call _printf
    add esp, 8

    xor eax, eax
    ret
