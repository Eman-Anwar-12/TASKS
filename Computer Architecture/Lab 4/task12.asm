; Lab 4 - Task 12: Branch Elimination via Predication and Conditional Moves
; Part 3: Control Hazards & Branch Architectures
; Objective: Eliminate control hazards using branchless arithmetic.
; Hazard: Control Hazard (misprediction penalties).

.data
.text
.globl main
main:
    li   $t0, -42           # Input value

    # Approach A: Branching Absolute Value (prone to branch misprediction)
    move $t1, $t0
    bgez $t1, skip_neg
    sub  $t1, $zero, $t1    # Negate if negative
skip_neg:

    # Approach B: Branchless Absolute Value using Sign Masking (0 control hazards)
    sra  $t2, $t0, 31       # Sign mask: 0x00000000 if >=0, 0xFFFFFFFF if <0
    xor  $t3, $t0, $t2       # Invert bits if negative
    sub  $t3, $t3, $t2       # Add 1 if negative (two's complement abs)

    # Approach C: Conditional Move (movn / movz)
    sub  $t4, $zero, $t0    # Pre-negated value
    slt  $t5, $t0, $zero    # $t5 = 1 if $t0 < 0, else 0
    movn $t0, $t4, $t5      # Move pre-negated value into $t0 conditionally if $t5 != 0

    li   $v0, 10
    syscall
