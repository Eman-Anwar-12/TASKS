; Lab 3 - Task 3: Manual NOP Insertion (Distance 2)
; Section 1: RAW Hazards without Forwarding
;
; Concept:
; When an independent instruction is located between the producer and consumer,
; it acts as a functional bubble of 1 cycle. The consumer instruction enters ID
; at CC3 instead of CC2. Because the producer commits to the register file at
; the start of CC5, only 1 additional cycle of stall is required (5 - 3 - 1 = 1 NOP).
;
; Pseudocode:
; R2 = R4 + R5         // Producer: commits R2 at CC5
; R6 = R7 & R8         // Independent instruction occupies cycle CC3 ID
; Wait 1 cycle (NOP)   // Absorbs cycle CC4 ID
; R9 = R2 | R10        // Consumer reaches ID at CC5 (safe read)

.data
.text
.globl main
main:
    ADD $2, $4, $5      # Producer: commits R2 at CC5
    AND $6, $7, $8      # Useful instruction hides 1 pipeline cycle
    NOP                 # Required to reach CC5
    OR  $9, $2, $10     # ID stage aligned with WB stage of ADD

    li $v0, 10
    syscall
