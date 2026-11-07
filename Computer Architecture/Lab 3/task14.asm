; Lab 3 - Task 14: Dot Product Element Interleaving
; Section 3: Instruction Scheduling
;
; Concept:
; Vector operations frequently encounter load latency followed by multi-cycle execution
; latency (such as multiplication). Interleaving the load instructions for iteration i + 1
; with the arithmetic operations of iteration i keeps both the memory bus and the ALU
; pipeline busy, masking pipeline latency.
;
; Pseudocode:
; X0 = Memory[R1 + 0]
; Y0 = Memory[R2 + 0]
; X1 = Memory[R1 + 4]  // Pre-fetch next pair to absorb load-use delay
; MUL R6, X0, Y0       // Operates on ready operands
; ADD R10, R10, R6     // Accumulate

.data
.text
.globl main
main:
    LW  $3, 0($1)       # Load X0
    LW  $4, 0($2)       # Load Y0
    LW  $5, 4($1)       # Load X1 (pre-fetch to absorb latency)
    MUL $6, $3, $4      # ALU multiplication
    ADD $10, $10, $6    # Accumulate into running sum

    li $v0, 10
    syscall
