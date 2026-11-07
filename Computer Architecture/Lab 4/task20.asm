; Lab 4 - Task 20: Instruction-Cache Synchronization Hazards
; Part 4: Loop Transformations & Pipeline Optimization
; Objective: Investigate coherency between I-Cache and D-Cache in pipelined execution.
; Hazard: Structural & Control Hazard (coherency stall).

.data
.text
.globl main
main:
    la   $t0, dynamic_target

    # Self-modifying code: Overwrite upcoming opcode at dynamic_target
    # Opcode 0x2002000A = addi $v0, $zero, 10
    li   $t1, 0x2002000A
    sw   $t1, 0($t0)        # D-Cache modified, but I-Cache may hold stale copy

    # Without I-Cache flush / synchronization instruction, the CPU pipeline
    # fetches stale instructions from I-Cache instead of the newly written memory.
dynamic_target:
    nop                     # Will be replaced dynamically by modified instruction

    li   $v0, 10
    syscall
