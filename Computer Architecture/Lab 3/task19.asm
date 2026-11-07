; Lab 3 - Task 19: Structural Hazard (Single Unified Memory)
; Section 5: Structural and Combined Hazards
;
; Concept:
; A structural hazard occurs when two pipeline stages attempt to access the same
; physical hardware resource simultaneously. In a processor with a unified memory
; (single port for both instructions and data), an instruction fetch (IF) and a memory
; read/write (MEM) will conflict. Modern pipelines use split Harvard caches (I-Cache & D-Cache).
;
; Pseudocode:
; Inst 1: LW accesses data memory in MEM stage (Clock Cycle 4)
; Inst 4: Fetches instruction opcode in IF stage (Clock Cycle 4)
; // Conflict: A single memory port cannot serve both IF and MEM simultaneously

.data
.text
.globl main
main:
    LW  $1, 0($2)       # Cycle 4: MEM stage accesses unified memory
    ADD $3, $4, $5
    SUB $6, $7, $8
    AND $9, $10, $11    # Cycle 4: IF stage stalls due to memory bus conflict

    li $v0, 10
    syscall
