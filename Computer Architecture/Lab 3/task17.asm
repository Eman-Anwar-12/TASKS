; Lab 3 - Task 17: Branch Delay Slot: NOP Fallback
; Section 4: Control Hazards and Branch Delays
;
; Concept:
; If an instruction modifies a register that is directly evaluated by a branch instruction,
; moving it into the branch delay slot would cause the branch to evaluate the previous,
; incorrect register value. When no independent instruction is available to fill the slot,
; the compiler must insert a NOP to preserve program semantics.
;
; Pseudocode:
; R4 = R4 - 1          // Producer of branch condition
; if (R4 == 0) goto EXIT // Depends on preceding instruction
; // Cannot move decrement after branch without altering logic; insert NOP

.data
.text
.globl main
main:
    SUB $4, $4, 1       # Decrement R4
    BEQ $4, $0, EXIT    # Branch depends on updated R4
    NOP                 # Delay slot fallback preserving program logic
EXIT:
    li $v0, 10
    syscall
