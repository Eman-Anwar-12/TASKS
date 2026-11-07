; Lab 3 - Task 8: Back-to-Back Address Dependency
; Section 2: Load-Use Hazards with Forwarding
;
; Concept:
; When a load instruction produces an address that is used as the base pointer
; by a subsequent load, the base address must be present at the ALU input during
; the second load's EX stage to calculate the effective memory address (R1 + 4).
; This is structurally identical to a standard load-use hazard and enforces a mandatory 1-cycle stall.
;
; Pseudocode:
; R1 = Memory[R2 + 0]  // Load pointer R1
; Wait 1 cycle (Stall)  // Effective address ALU unit needs R1 at CC5 EX
; R3 = Memory[R1 + 4]  // Memory read using forwarded pointer R1

.data
.text
.globl main
main:
    LW  $1, 0($2)       # Load pointer R1
    NOP                 # Cannot reorder without outside instructions (1-cycle stall)
    LW  $3, 4($1)       # Memory read using forwarded pointer R1

    li $v0, 10
    syscall
