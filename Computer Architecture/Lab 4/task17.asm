; Lab 4 - Task 17: Software Pipelining (Modulo Scheduling)
; Part 4: Loop Transformations & Pipeline Optimization
; Objective: Emulate hardware pipelining principles at the software assembly level.
; Hazard: Data Hazard (RAW) (eliminated within kernel).

.data
    src: .word 10, 20, 30, 40, 50, 60
    dst: .word 0, 0, 0, 0, 0, 0
.text
.globl main
main:
    la   $a0, src
    la   $a1, dst
    li   $t0, 4             # Steady state iterations

    # === PROLOGUE ===
    # Prime the pipeline: Load iteration 0 and 1, Compute iteration 0
    lw   $t1, 0($a0)        # Load k+2 (iter 0)
    lw   $t2, 4($a0)        # Load k+1 (iter 1)
    addi $t3, $t1, 5        # Compute k (iter 0)
    addi $a0, $a0, 8

    # === STEADY-STATE KERNEL ===
    # Iteration k stores, iteration k+1 computes, iteration k+2 loads concurrently
sw_pipe_loop:
    sw   $t3, 0($a1)        # STORE: Iteration k
    addi $t3, $t2, 5        # COMPUTE: Iteration k+1
    lw   $t2, 0($a0)        # LOAD: Iteration k+2

    addi $a0, $a0, 4
    addi $a1, $a1, 4
    addi $t0, $t0, -1
    bgtz $t0, sw_pipe_loop

    # === EPILOGUE ===
    # Drain remaining elements
    sw   $t3, 0($a1)        # Store final computed element
    addi $t3, $t2, 5
    sw   $t3, 4($a1)

    li   $v0, 10
    syscall
