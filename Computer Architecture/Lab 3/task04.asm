; Lab 3 - Task 4: Multi-Operand Hazard
; Section 1: RAW Hazards without Forwarding
;
; Concept:
; When an instruction depends on multiple prior instructions, the stall penalty
; is governed by the youngest producer (the instruction with the smallest distance).
; The instruction with distance 1 needs 2 delay cycles, which simultaneously
; satisfies the requirement for the instruction with distance 2.
;
; Pseudocode:
; R1 = R3 + R4         // Producer 1 (distance = 2 relative to consumer)
; R2 = R5 + R6         // Producer 2 (distance = 1 relative to consumer)
; Wait 2 cycles        // Stalling for R2 concurrently resolves R1
; R7 = R1 + R2         // Consumer reads both R1 and R2 safely

.data
.text
.globl main
main:
    ADD $1, $3, $4      # Producer 1 (distance 2)
    ADD $2, $5, $6      # Producer 2 (distance 1)
    NOP                 # Bubble 1
    NOP                 # Bubble 2
    ADD $7, $1, $2      # Consumer: reads R1 and R2 safely

    li $v0, 10
    syscall
