; Task 20: Mini Complete Program
; 1. Put 10 into AL.
; 2. Add 20.
; 3. Subtract 5.
; 4. Store the result in memory.
; 5. Read the result into BL.
; 6. Display AL, BL, and the value stored in memory.

global _main
extern _printf

section .data
    result db 0
    format db "AL = %d, BL = %d, Memory = %d", 10, 0

section .text
_main:
    ; Step 1: Put 10 into AL
    mov al, 10

    ; Step 2: Add 20 (10 + 20 = 30)
    add al, 20

    ; Step 3: Subtract 5 (30 - 5 = 25)
    sub al, 5

    ; Step 4: Store in memory
    mov [result], al

    ; Step 5: Read into BL
    mov bl, [result]

    ; Step 6: Prepare arguments for printf
    movzx eax, al
    movzx ecx, bl
    movzx edx, byte [result]

    push edx
    push ecx
    push eax
    push format
    call _printf

    add esp, 16

    xor eax, eax
    ret
