; Lab 3 - Task 12: Double Load Scheduling
; Section 3: Instruction Scheduling
;
; Concept:
; When loading two values to be used in separate arithmetic instructions, interweaving
; the loads and operations eliminates two separate load-use stalls. Placing the second
; load instruction immediately after the first load fills the first load's latency slot.
; The first arithmetic instruction subsequently fills the second load's latency slot.
;
; Pseudocode:
; R1 = Memory[R4 + 0]  // Load A
; R6 = Memory[R4 + 4]  // Load B: fills load-use delay of Load A
; R2 = R1 + R5          // Compute with A: fills load-use delay of Load B
; R7 = R6 + R8          // Compute with B: perfectly synchronized

.data
.text
.globl main
main:
    LW  $1, 0($4)       # Load A
    LW  $6, 4($4)       # Load B: fills load-use slot of Load A
    ADD $2, $1, $5      # Compute with A: fills load-use slot of Load B
    ADD $7, $6, $8      # Compute with B: perfectly synchronized

    li $v0, 10
    syscall
