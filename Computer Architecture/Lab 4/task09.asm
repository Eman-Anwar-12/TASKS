; Lab 4 - Task 9: Distance-1 vs. Distance-2 Forwarding Path Analysis
; Part 2: Data Hazards (RAW) & Software Scheduling
; Objective: Differentiate between EX-to-EX and MEM-to-EX forwarding networks.
; Hazard: Data Hazard (RAW).

.data
.text
.globl main
main:
    li   $t1, 10
    li   $t2, 20
    li   $t3, 30
    li   $t6, 50

    # Sequence 1: Distance 1 (Adjacent instructions)
    # Forwarding path: EX/MEM register -> ALU input (EX-to-EX mux activated)
    add  $t0, $t1, $t2      # Producer generates result in EX
    sub  $t4, $t0, $t3      # Consumer at Distance 1 uses EX-to-EX bypass

    # Sequence 2: Distance 2 (Separated by 1 independent instruction)
    # Forwarding path: MEM/WB register -> ALU input (MEM-to-EX mux activated)
    add  $s0, $t1, $t2      # Producer generates result
    add  $s7, $t6, 1        # Independent instruction (Distance = 2)
    sub  $s1, $s0, $t3      # Consumer uses MEM-to-EX bypass

    li   $v0, 10
    syscall
