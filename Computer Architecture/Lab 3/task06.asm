; Lab 3 - Task 6: The Classic Load-Use Stall
; Section 2: Load-Use Hazards with Forwarding
;
; Architectural Assumption:
; EX-to-EX and MEM-to-EX forwarding networks are present.
;
; Concept:
; A memory load (LW) retrieves its data from memory during the MEM stage (end of CC4).
; However, an immediately subsequent ALU operation requires its inputs at the beginning
; of the EX stage (start of CC4). Because data cannot travel backward in time, forwarding
; alone cannot prevent a stall; the pipeline must insert a hardware bubble (or 1 NOP)
; so the MEM output matches the EX input timing at CC5.
;
; Pseudocode:
; R1 = Memory[R2 + 0]  // Data available only at the end of MEM (CC4)
; Wait 1 cycle (Stall)  // Delay EX of consumer to CC5
; R3 = R1 + R4          // MEM-to-EX forwarding provides R1 at CC5

.data
.text
.globl main
main:
    LW  $1, 0($2)       # Load data from memory
    NOP                 # 1-cycle stall bubble inserted by hardware/compiler
    ADD $3, $1, $4      # ALU consumer receives forwarded R1 at CC5

    li $v0, 10
    syscall
