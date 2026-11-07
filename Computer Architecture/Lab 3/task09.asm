; Lab 3 - Task 9: Store After Arithmetic
; Section 2: Load-Use Hazards with Forwarding
;
; Concept:
; An arithmetic operation computes its result in the EX stage (CC3). A subsequent
; store instruction writes this data to memory during its MEM stage (CC4). Because
; the producer calculates the value before the consumer enters its MEM stage, an
; EX-to-MEM forwarding path supplies the data directly to the write buffer without incurring stalls.
;
; Pseudocode:
; R4 = R2 + R3          // Value generated at end of EX (CC3)
; Memory[R5 + 0] = R4   // Value consumed at start of MEM (CC4) -> 0 stalls

.data
.text
.globl main
main:
    ADD $4, $2, $3      # Compute value at CC3 EX
    SW  $4, 0($5)       # Completely hazard-free with EX-to-MEM forwarding

    li $v0, 10
    syscall
