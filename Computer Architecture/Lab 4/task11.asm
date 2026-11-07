; Lab 4 - Task 11: Branch Delay Slot Scheduling
; Part 3: Control Hazards & Branch Architectures
; Objective: Optimize execution on architectures utilizing architectural delay slots.
; Hazard: Control Hazard (architectural delay latency).

.data
.text
.globl main
main:
    li   $t0, 5
    li   $t1, 0

    # Original unoptimized: branch followed by idle NOP in delay slot
    # beq  $t0, $zero, done
    # nop

    # Optimized: Move independent decrement instruction into delay slot
loop_delay:
    bne  $t0, $zero, loop_delay # Branch decision in ID
    addi $t0, $t0, -1           # DELAY SLOT: Executes unconditionally every loop cycle

done:
    li   $v0, 10
    syscall
