; Lab 4 - Task 1: Dual-Port vs. Single-Port Memory Contention
; Part 1: Structural Hazards & Latency Contention
; Objective: Trace the impact of unified memory architecture vs split Harvard architecture.
; Hazard: Structural Hazard (memory port conflict during concurrent IF and MEM stages).

.data
    buffer: .word 10, 20, 30, 40, 50, 60, 70, 80
.text
.globl main
main:
    la   $s0, buffer        # Base address of buffer
    li   $t0, 100           # Loop counter (100 iterations)

mem_loop:
    # In unified memory, IF of next instruction conflicts with MEM stage of LW/SW
    lw   $t1, 0($s0)        # Access data memory (MEM stage)
    add  $t1, $t1, 1        # Increment value
    sw   $t1, 0($s0)        # Store back to data memory (MEM stage)
    
    addi $t0, $t0, -1       # Decrement loop counter
    bgtz $t0, mem_loop      # Loop if counter > 0

    li   $v0, 10            # Exit
    syscall
