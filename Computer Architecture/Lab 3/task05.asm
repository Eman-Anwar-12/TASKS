; Lab 3 - Task 5: Chain of Cumulative Additions
; Section 1: RAW Hazards without Forwarding
;
; Concept:
; In an accumulator chain where each step depends on the immediate predecessor,
; no independent instructions exist to fill the latency. Consequently, every dependent
; arithmetic operation in the sequence incurs a full 2-cycle bubble without forwarding,
; causing severe pipeline execution degradation.
;
; Pseudocode:
; R1 = R1 + R2
; Wait 2 cycles
; R1 = R1 + R3         // Dependent on previous R1
; Wait 2 cycles
; R1 = R1 + R4         // Dependent on previous R1

.data
.text
.globl main
main:
    ADD $1, $1, $2      # First addition
    NOP                 # Stall cycle 1
    NOP                 # Stall cycle 2
    ADD $1, $1, $3      # Second addition (depends on R1)
    NOP                 # Stall cycle 1
    NOP                 # Stall cycle 2
    ADD $1, $1, $4      # Third addition (depends on R1)

    li $v0, 10
    syscall
