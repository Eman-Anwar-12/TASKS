; Lab 4 - Task 7: Loop-Carried Accumulation Dependencies
; Part 2: Data Hazards (RAW) & Software Scheduling
; Objective: Eliminate dependency serializations across loop iterations.
; Hazard: Data Hazard (RAW / Loop-Carried Dependency).

.data
    arr: .word 1, 2, 3, 4, 5, 6, 7, 8
.text
.globl main
main:
    la   $s0, arr
    li   $s1, 0             # Accumulator 1
    li   $s2, 0             # Accumulator 2 (dual accumulators break dependency)
    li   $t0, 4             # Loop count (processes 2 elements per iteration)

accum_loop:
    lw   $t1, 0($s0)        # Load element i
    lw   $t2, 4($s0)        # Load element i+1
    add  $s1, $s1, $t1      # Accumulate into sum 1 (interleaved)
    add  $s2, $s2, $t2      # Accumulate into sum 2 (independent of sum 1)
    addi $s0, $s0, 8        # Advance pointer by 2 words
    addi $t0, $t0, -1
    bgtz $t0, accum_loop

    # Merge partial accumulators
    add  $s0, $s1, $s2      # Final total sum

    li   $v0, 10
    syscall
