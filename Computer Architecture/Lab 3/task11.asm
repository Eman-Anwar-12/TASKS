; Lab 3 - Task 11: Arithmetic Expression Scheduling: (A + B) + (C + D)
; Section 3: Instruction Scheduling
; Architectural Goal: Maximize pipeline throughput (CPI ~ 1) through static compiler reordering.
;
; Concept:
; Evaluating expressions with tree structures reveals independent subexpressions.
; Computing (A + B) and (C + D) sequentially separates the first addition from the root
; addition by 1 cycle, guaranteeing that the result of the first addition is stabilized
; in the pipeline register before the final addition requires both operands.
;
; Pseudocode:
; Temp1 = A + B         // Operation 1
; Temp2 = C + D         // Operation 2: Independent; separates Op 1 and Op 3
; Result = Temp1 + Temp2

.data
.text
.globl main
main:
    ADD $5, $1, $2      # R5 = A + B
    ADD $6, $3, $4      # R6 = C + D (decouples R5 from final addition)
    ADD $7, $5, $6      # R7 = Temp1 + Temp2 (both operands ready)

    li $v0, 10
    syscall
