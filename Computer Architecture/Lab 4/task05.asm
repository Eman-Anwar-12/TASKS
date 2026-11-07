; Lab 4 - Task 5: Exposing the Load-Use Forwarding Penalty
; Part 2: Data Hazards (RAW) & Software Scheduling
; Objective: Demonstrate that hardware bypassing cannot eliminate all pipeline stalls.
; Hazard: Data Hazard (RAW / Load-Use Delay).

.data
    val: .word 42
.text
.globl main
main:
    la   $a0, val
    li   $t2, 8

    # Memory load followed immediately by dependent ALU instruction.
    # Data is not available until end of MEM (CC4).
    # ALU needs operand at start of EX (CC4).
    # Hardware must insert 1 stall bubble even with full forwarding.
    lw   $t0, 0($a0)        # Data loaded in MEM stage
    add  $t1, $t0, $t2      # Mandatory 1-cycle hardware stall bubble inserted here

    li   $v0, 10
    syscall
