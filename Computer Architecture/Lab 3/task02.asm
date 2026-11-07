; Lab 3 - Task 2: Manual NOP Insertion (Distance 1)
; Section 1: RAW Hazards without Forwarding
;
; Concept:
; The producer instruction (ADD) enters WB at clock cycle 5 (CC5), writing the
; register file during the first half of the cycle. A dependent instruction
; entering ID at CC5 can safely read the updated value during the second half of CC5.
; Because an instruction directly following the producer enters ID at CC2, it must
; be delayed until CC5, requiring 5 - 2 - 1 = 2 intervening null operations (NOPs).
;
; Pseudocode:
; R1 = R2 + R3
; Wait 1 cycle (NOP)
; Wait 1 cycle (NOP)
; R4 = R1 - R5     // Executes ID stage at CC5 (safe read)

.data
.text
.globl main
main:
    ADD $1, $2, $3      # CC1: IF, CC2: ID, CC3: EX, CC4: MEM, CC5: WB
    NOP                 # CC2: IF, CC3: ID, CC4: EX, CC5: MEM, CC6: WB
    NOP                 # CC3: IF, CC4: ID, CC5: EX, CC6: MEM, CC7: WB
    SUB $4, $1, $5      # CC4: IF, CC5: ID (reads R1 after WB write)

    li $v0, 10
    syscall
