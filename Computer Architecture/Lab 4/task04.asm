; Lab 4 - Task 4: Software Hazard Resolution via NOP Insertion
; Part 2: Data Hazards (RAW) & Software Scheduling
; Objective: Mitigate data hazards when hardware forwarding is disabled.
; Hazard: Data Hazard (RAW) under non-forwarding pipeline configurations.

.data
.text
.globl main
main:
    li   $t2, 10
    li   $t3, 20
    li   $t5, 5

    # Dependent chain: R1 <- R2 + R3; R4 <- R1 + R5
    # Without forwarding, R1 writes at first half of CC5 (WB).
    # Consumer must enter ID at CC5. Minimum 2 NOPs required:
    add  $t1, $t2, $t3      # Producer: updates $t1 in CC5 (WB)
    nop                     # Bubble 1 (CC3)
    nop                     # Bubble 2 (CC4)
    add  $t4, $t1, $t5      # Consumer: enters ID at CC5, reads safe committed $t1

    li   $v0, 10
    syscall
