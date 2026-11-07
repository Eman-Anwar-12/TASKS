; Lab 3 - Task 16: Branch Delay Slot: Moving from Before
; Section 4: Control Hazards and Branch Delays
;
; Concept:
; In architectures that implement architectural branch delay slots (e.g., classical MIPS),
; the instruction in the slot following the branch is always executed, whether the branch
; is taken or not. The most efficient compiler optimization is moving a safe, independent
; instruction from before the branch into the delay slot.
;
; Pseudocode:
; // Original: ADD R1, R2, R3 then BEQ R4, R5
; if (R4 == R5) goto TARGET
; Execute R1 = R2 + R3 in delay slot (safe: does not influence branch registers)

.data
.text
.globl main
main:
    BEQ $4, $5, TARGET  # Branch condition evaluated
    ADD $1, $2, $3      # Instruction in delay slot always executes safely
TARGET:
    li $v0, 10
    syscall
