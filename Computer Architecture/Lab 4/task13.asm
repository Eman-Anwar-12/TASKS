; Lab 4 - Task 13: Static Heuristic Alignment: BTFN Evaluation
; Part 3: Control Hazards & Branch Architectures
; Objective: Analyze Backwards-Taken, Forwards-Not-Taken (BTFN) branch prediction.
; Hazard: Control Hazard.

.data
    arr: .word 1, 2, 3, 4, 5
.text
.globl main
main:
    la   $s0, arr
    li   $t0, 5             # Count

    # Structure 1: Forward-branching while (causes misprediction under BTFN)
while_start:
    blez $t0, while_exit    # Forward branch: BTFN predicts NOT-TAKEN (mispredicted on exit)
    addi $t0, $t0, -1
    j    while_start
while_exit:

    # Structure 2: Backward-branching do-while (aligns with BTFN: Backwards-Taken)
    li   $t1, 5
dowhile_body:
    addi $t1, $t1, -1
    bgtz $t1, dowhile_body  # Backward branch: BTFN correctly predicts TAKEN during loops

    li   $v0, 10
    syscall
