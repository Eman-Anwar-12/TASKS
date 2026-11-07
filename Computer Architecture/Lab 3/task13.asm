; Lab 3 - Task 13: Array Element Swapping
; Section 3: Instruction Scheduling
;
; Concept:
; A memory swap operation involves reading two elements and writing them to alternate
; memory addresses. By scheduling both memory reads consecutively, the second load
; instruction absorbs the latency of the first load. Stores do not suffer from load-use
; stalls when forwarding is present, resulting in optimal memory-to-memory throughput.
;
; Pseudocode:
; ValA = Memory[R2 + 0]
; ValB = Memory[R2 + 4] // Fills delay of ValA
; Memory[R2 + 4] = ValA // ValA forwarded to MEM stage
; Memory[R2 + 0] = ValB // ValB forwarded to MEM stage

.data
.text
.globl main
main:
    LW  $3, 0($2)       # Load ValA
    LW  $4, 4($2)       # Load ValB (absorbs latency of ValA)
    SW  $3, 4($2)       # Store ValA into alternate address
    SW  $4, 0($2)       # Store ValB into original address

    li $v0, 10
    syscall
