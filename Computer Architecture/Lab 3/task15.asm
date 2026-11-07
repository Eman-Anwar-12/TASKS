; Lab 3 - Task 15: Branch Stall Penalty Calculation
; Section 4: Control Hazards and Branch Delays
; Architectural Assumption: Branch decision hardware is located in the ID stage.
;
; Concept:
; If branch target calculation and register equality checks take place in the EX stage
; (stage 3), the correct instruction cannot be fetched until CC4. This creates a 2-cycle
; control hazard penalty where speculative instructions in IF and ID must be flushed.
; Moving branch resolution to the ID stage reduces this penalty to 1 clock cycle.
;
; Pseudocode:
; if (R1 == R2) goto TARGET
; // If resolved in EX: 2 instructions flushed (penalty = 2 cycles)
; // If resolved in ID: 1 instruction flushed (penalty = 1 cycle)

.data
.text
.globl main
main:
    BEQ $1, $2, TARGET  # Pipeline flushes subsequent instructions if branch condition is true
    NOP                 # Flushed bubble if branch taken
TARGET:
    li $v0, 10
    syscall
