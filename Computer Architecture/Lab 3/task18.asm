; Lab 3 - Task 18: Unconditional Jump Delay
; Section 4: Control Hazards and Branch Delays
;
; Concept:
; Unconditional jumps (J) also feature a delay slot in delayed-branch architectures.
; Because the branch is guaranteed to be taken, loop counters or pointer increments
; can be placed directly in the delay slot, executing every iteration while hiding jump latency.
;
; Pseudocode:
; Loop:
;   goto Loop
;   R1 = R1 - 1        // Executes on every jump iteration

.data
.text
.globl main
main:
LOOP:
    J   LOOP            # Unconditional jump
    SUB $1, $1, 1       # Delay slot instruction executes prior to loop jump target execution

    li $v0, 10
    syscall
