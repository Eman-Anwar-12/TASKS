; Lab 4 - Task 15: Two-Way Loop Unrolling
; Part 4: Loop Transformations & Pipeline Optimization
; Objective: Reduce branch overhead and expose instruction-level parallelism (ILP).
; Hazard: Data (Load-Use) and Control Hazards.

.data
    vecA: .word 1, 2, 3, 4, 5, 6, 7, 8
    vecB: .word 8, 7, 6, 5, 4, 3, 2, 1
.text
.globl main
main:
    la   $a0, vecA
    la   $a1, vecB
    li   $s0, 0             # Dot product sum
    li   $t0, 4             # Unrolled count: 8 elements / 2 = 4 iterations

unroll2_loop:
    # Iteration i and i+1 loads interleaved to hide memory latency
    lw   $t1, 0($a0)        # Load A[i]
    lw   $t2, 0($a1)        # Load B[i]
    lw   $t3, 4($a0)        # Load A[i+1]
    lw   $t4, 4($a1)        # Load B[i+1]

    mul  $t5, $t1, $t2      # A[i] * B[i]
    mul  $t6, $t3, $t4      # A[i+1] * B[i+1]

    add  $s0, $s0, $t5      # Accumulate iteration i
    add  $s0, $s0, $t6      # Accumulate iteration i+1

    addi $a0, $a0, 8        # Advance pointer by 2 words
    addi $a1, $a1, 8
    addi $t0, $t0, -1
    bgtz $t0, unroll2_loop

    li   $v0, 10
    syscall
