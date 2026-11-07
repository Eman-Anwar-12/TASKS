; Lab 4 - Task 8: Memory-to-Memory Store Forwarding Verification
; Part 2: Data Hazards (RAW) & Software Scheduling
; Objective: Examine pipeline interaction with store buffers and memory forwarding.
; Hazard: Data Hazard (RAW through Memory).

.data
    location: .word 0
.text
.globl main
main:
    la   $s0, location
    li   $t0, 0xCAFE

    # Store followed immediately by load to identical address
    sw   $t0, 0($s0)        # Data enters write buffer / store queue
    lw   $t1, 0($s0)        # Store-to-load forwarding routes data directly to $t1 without waiting for RAM write

    li   $v0, 10
    syscall
