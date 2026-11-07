; Lab 4 - Task 18: Subroutine Call and Return Pipeline Overhead
; Part 4: Loop Transformations & Pipeline Optimization
; Objective: Quantify control stalls associated with indirect jumps.
; Hazard: Control Hazard (jump register latency).

.data
.text
.globl main
main:
    li   $s0, 0             # Result accumulator
    li   $t0, 1000          # Iteration count

bench_loop:
    # Calling subroutine incurs:
    # 1. Pipeline flush on JAL target address fetch
    # 2. Register write to $ra
    # 3. Pipeline flush on JR $ra return
    jal  calc_subroutine
    addi $t0, $t0, -1
    bgtz $t0, bench_loop

    li   $v0, 10
    syscall

calc_subroutine:
    addi $s0, $s0, 3        # Subroutine computation
    jr   $ra                # Control stall on indirect register jump
