; Lab 3 - Task 10: Load-to-Store Forwarding
; Section 2: Load-Use Hazards with Forwarding
;
; Concept:
; In a memory-to-memory transfer sequence, the load instruction reads memory in
; MEM (CC4). The store instruction requires the data word in its own MEM stage (CC5).
; Because the arrival of data from the load stage aligns with the input cycle of the
; store stage, a dedicated MEM-to-MEM bypass path routes data directly between memory
; registers with 0 stalls.
;
; Pseudocode:
; R1 = Memory[R2 + 0]  // Read data ready at end of MEM stage (CC4)
; Memory[R3 + 0] = R1  // Write data required at start of MEM stage (CC5)

.data
.text
.globl main
main:
    LW  $1, 0($2)       # Read data ready at end of MEM stage (CC4)
    SW  $1, 0($3)       # 0 stalls with MEM-to-MEM forwarding

    li $v0, 10
    syscall
