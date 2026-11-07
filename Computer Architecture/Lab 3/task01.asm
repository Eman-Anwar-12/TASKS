; Lab 3 - Task 1: Spot the RAW Dependency
; Section 1: RAW Hazards without Forwarding
;
; Concept:
; A Read-After-Write (RAW) hazard occurs because the producer instruction
; writes its destination register in stage 5 (WB), but the consumer instruction
; needs to read that same register during stage 2 (ID). In sequential execution
; without hardware interlocks or bypassing, reading an unwritten register yields stale data.
;
; Pseudocode:
; R1 = R2 + R3     // Producer: updates R1 in cycle 5 (WB)
; R4 = R1 - R5     // Consumer: attempts to read R1 in cycle 2 (ID)
; // Hazard: R1 is read 3 cycles before it is committed to the register file

.data
.text
.globl main
main:
    ADD $1, $2, $3      # Producer: R1 = R2 + R3
    SUB $4, $1, $5      # Consumer: Register R1 triggers a RAW hazard

    # Exit program (MIPS syscall)
    li $v0, 10
    syscall
