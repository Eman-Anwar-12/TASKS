; Lab 3 - Task 7: Load-Use with Independent Work
; Section 2: Load-Use Hazards with Forwarding
;
; Concept:
; Instruction-level parallelism (ILP) can be leveraged by compilers to eliminate
; load-use stalls. By scheduling an independent instruction immediately following
; the load, the pipeline is occupied for 1 clock cycle without stalling, allowing data
; to be loaded from memory and forwarded to the subsequent ALU stage at zero performance cost.
;
; Pseudocode:
; R1 = Memory[R2 + 0]  // Initiate memory load
; R5 = R6 - R7          // Execute independent arithmetic to cover load latency
; R3 = R1 + R4          // Forwarding path supplies R1 directly from MEM/WB

.data
.text
.globl main
main:
    LW  $1, 0($2)       # Load word
    SUB $5, $6, $7      # Useful independent work eliminates the load-use penalty
    ADD $3, $1, $4      # Forwarding path supplies R1 directly from MEM/WB

    li $v0, 10
    syscall
