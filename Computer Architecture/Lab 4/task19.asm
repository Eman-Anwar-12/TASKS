; Lab 4 - Task 19: Cache-Miss Pipeline Freeze Analysis
; Part 4: Loop Transformations & Pipeline Optimization
; Objective: Observe memory stalls halting the pipeline execution stages.
; Hazard: Data / Memory System Stall.

.data
    # Allocate a buffer of words
    buffer: .space 65536    # 64 KB buffer
.text
.globl main
main:
    la   $s0, buffer
    li   $t0, 1024          # Access count

    # Experiment 1: Sequential access (Stride = 4 bytes -> high cache line spatial hits)
seq_loop:
    lw   $t1, 0($s0)
    addi $s0, $s0, 4        # Stride = 4 bytes
    addi $t0, $t0, -1
    bgtz $t0, seq_loop

    # Experiment 2: Strided access (Stride = 64 bytes -> each access hits new cache line, causing pipeline freeze stalls)
    la   $s0, buffer
    li   $t0, 1024
stride_loop:
    lw   $t1, 0($s0)
    addi $s0, $s0, 64       # Stride = 64 bytes (exceeds cache line width)
    addi $t0, $t0, -1
    bgtz $t0, stride_loop

    li   $v0, 10
    syscall
