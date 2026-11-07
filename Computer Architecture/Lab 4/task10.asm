; Lab 4 - Task 10: Quantifying Taken vs. Not-Taken Branch Penalties
; Part 3: Control Hazards & Branch Architectures
; Objective: Measure pipeline flushing costs on taken vs. fall-through branches.
; Hazard: Control Hazard (pipeline flush penalties).

.data
.text
.globl main
main:
    # Benchmark 1: Branch taken 95% of time (measures Taken branch penalty)
    li   $t0, 1000          # 1000 iterations
loop_taken:
    addi $t0, $t0, -1
    bgtz $t0, loop_taken    # Taken on 999 of 1000 iterations (pipeline flushed if predicted NT)

    # Benchmark 2: Branch not-taken 95% of time (measures Fall-through efficiency)
    li   $t1, 1000
    li   $t2, 0
loop_not_taken:
    beq  $t2, 1, branch_target # Evaluates to false (Not Taken) 100% of time
    addi $t1, $t1, -1
    bgtz $t1, loop_not_taken
branch_target:

    li   $v0, 10
    syscall
