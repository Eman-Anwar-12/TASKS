; Lab 4 - Task 16: Four-Way Unrolling with Register Renaming
; Part 4: Loop Transformations & Pipeline Optimization
; Objective: Amortize loop branch penalties and avoid artificial dependencies.
; Hazard: Control Hazard & Anti-Dependencies.

.data
    arr: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
.text
.globl main
main:
    la   $a0, arr
    li   $s0, 0             # Accumulator Stream 0
    li   $s1, 0             # Accumulator Stream 1
    li   $s2, 0             # Accumulator Stream 2
    li   $s3, 0             # Accumulator Stream 3
    li   $t0, 4             # 16 elements / 4 = 4 iterations

unroll4_loop:
    # 4 distinct streams using independent renamed registers to break false dependencies (WAR/WAW)
    lw   $t1, 0($a0)
    lw   $t2, 4($a0)
    lw   $t3, 8($a0)
    lw   $t4, 12($a0)

    add  $s0, $s0, $t1      # Stream 0
    add  $s1, $s1, $t2      # Stream 1
    add  $s2, $s2, $t3      # Stream 2
    add  $s3, $s3, $t4      # Stream 3

    addi $a0, $a0, 16
    addi $t0, $t0, -1
    bgtz $t0, unroll4_loop

    # Sum streams together
    add  $s0, $s0, $s1
    add  $s2, $s2, $s3
    add  $s0, $s0, $s2      # Final total sum in $s0

    li   $v0, 10
    syscall
