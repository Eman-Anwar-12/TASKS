; Lab 3 - Task 20: Combined Load-Use and Branch Hazard
; Section 5: Structural and Combined Hazards
;
; Concept:
; Resolving branches early in the ID stage reduces control hazard penalties, but creates
; a tighter data dependency constraint. A load instruction produces its data at the end
; of the MEM stage (CC4). If a branch in the ID stage needs to evaluate this data, it must
; wait until the data is written to the register file (or forwarded to ID). This requires
; 2 stall cycles between the load and the branch.
;
; Pseudocode:
; R1 = Memory[R2 + 0]  // Data available after MEM stage (CC4)
; Wait 1 cycle (Stall)
; Wait 1 cycle (Stall)  // Delay branch ID to CC5 to receive forwarded data
; if (R1 == 0) goto TARGET // Evaluated in ID stage

.data
.text
.globl main
main:
    LW  $1, 0($2)       # Memory load
    NOP                 # Hardware/Compiler stall bubble 1
    NOP                 # Hardware/Compiler stall bubble 2
    BEQ $1, $0, TARGET  # Evaluated in ID stage using forwarded data
TARGET:
    li $v0, 10
    syscall
