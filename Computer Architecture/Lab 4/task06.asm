; Lab 4 - Task 6: Software Instruction Rescheduling
; Part 2: Data Hazards (RAW) & Software Scheduling
; Objective: Eliminate load-use latency penalties via static instruction reordering.
; Hazard: Data Hazard (RAW / Load-Use).

.data
    arr: .word 10, 20, 30, 40
.text
.globl main
main:
    la   $a0, arr
    li   $t2, 5
    li   $t5, 7

    # ORIGINAL (with 2 load-use penalties):
    # lw   $t0, 0($a0)
    # add  $t1, $t0, $t2     # STALL
    # lw   $t3, 4($a0)
    # sub  $t4, $t3, $t5     # STALL

    # REORDERED (0 stalls via interleaved independent instructions):
    lw   $t0, 0($a0)        # Initiate Load 1
    lw   $t3, 4($a0)        # Independent Load 2 fills Load 1 latency slot
    add  $t1, $t0, $t2      # Operates on ready $t0, fills Load 2 latency slot
    sub  $t4, $t3, $t5      # Operates on ready $t3 (hazard-free)

    li   $v0, 10
    syscall
