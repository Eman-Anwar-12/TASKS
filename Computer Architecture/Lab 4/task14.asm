; Lab 4 - Task 14: Dynamic Predictor Aliasing and Thrashing
; Part 3: Control Hazards & Branch Architectures
; Objective: Benchmark saturating counters against irregular branch sequences.
; Hazard: Control Hazard (dynamic predictor misprediction).

.data
.text
.globl main
main:
    li   $t0, 1000          # 1000 iterations
    li   $t1, 0             # Alternating condition flag

test_loop:
    # Irregular pattern: alternating Taken / Not-Taken (T, NT, T, NT...)
    # 2-bit saturating counter constantly thrashes between states 01 and 10,
    # achieving near 100% misprediction rate.
    andi $t2, $t1, 1
    beq  $t2, 0, branch_alt # Alternates every single iteration
    nop
branch_alt:
    addi $t1, $t1, 1
    addi $t0, $t0, -1
    bgtz $t0, test_loop

    li   $v0, 10
    syscall
