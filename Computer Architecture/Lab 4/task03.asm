; Lab 4 - Task 3: Register File Write-Port Contention
; Part 1: Structural Hazards & Latency Contention
; Objective: Identify structural writeback conflicts between multicycle and single-cycle instructions.
; Hazard: Structural Hazard (WB stage port serialization).

.data
.text
.globl main
main:
    li   $t0, 15
    li   $t1, 4
    li   $t2, 25
    li   $t3, 35

    # Variable-latency multicycle instruction (e.g. mult/mflo) and 1-cycle ALU op
    # scheduled to arrive at the WB stage on the exact same cycle.
    mul  $s0, $t0, $t1      # Multi-cycle operation: completes in WB at cycle N
    add  $s1, $t2, $t3      # 1-cycle ALU operation: without arbitration would hit WB at cycle N
    # Hardware arbitrates single WB write-port by inserting a 1-cycle stall bubble

    li   $v0, 10
    syscall
