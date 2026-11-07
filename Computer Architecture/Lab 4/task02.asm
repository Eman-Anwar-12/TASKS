; Lab 4 - Task 2: Multicycle Functional Unit Stalls
; Part 1: Structural Hazards & Latency Contention
; Objective: Profile and mitigate execution latency penalties from multicycle execution units.
; Hazard: Structural / Functional Unit Latency Hazard.

.data
.text
.globl main
main:
    li   $t0, 1000
    li   $t1, 7
    li   $t2, 10
    li   $t3, 20

    # Sequence A: Unscheduled (immediate read from multicycle divider causes pipeline freeze)
    div  $t0, $t1           # Multicycle divider takes ~32 cycles
    mflo $t4                # STALL: EX stage waits for divider functional unit
    add  $s0, $t2, $t3      # Independent ALU instruction

    # Sequence B: Scheduled (Independent instructions mask division latency)
    div  $t0, $t1           # Initiate division
    add  $s1, $t2, $t3      # Independent ALU work executed while divider is busy
    sub  $s2, $t3, $t2      # Independent ALU work
    mflo $t5                # Result read with reduced or 0 stall latency

    li   $v0, 10
    syscall
