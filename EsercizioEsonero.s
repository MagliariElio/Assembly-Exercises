.data
i: .word 3
 
.text
main:
    la $a0, i
    lw $a0, 0($a0)
   
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal f
    lw $ra, 0($sp)
    addi $sp, $sp, 4
   
    add $a0, $v0, $0
    addi $v0, $0, 1
    syscall
   
    jr $ra
   
f:
    slti $t0, $a0, 2
    beq $t0, $0, else
    addi $v0, $0, 1
    jr $ra
   
else:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
   
    add $s0, $a0, $0
   
    addi $a0, $s0, -2
    jal f
    sll $s1, $v0, 1
   
    addi $a0, $s0, -1
    jal g
    sll $t0, $v0, 2
    add $v0, $v0, $t0
    add $v0, $v0, $s1
    add $v0, $s0, $v0
    addi $s0, $0, -3
   
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra
   
g:
    slti $t0, $a0, 3
    beq $t0, $0, elseg
    addi $v0, $0, 4
    jr $ra
   
elseg:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
   
    add $s0, $a0, $0
    srl $a0, $s0, 1
    jal f
    add $s1, $v0, $0
    addi $a0, $s0, -1
    jal g
    addi $a1, $v0, 0
    addi $a0, $s1, 0
    addi $a2, $s0, 0
   
    jal min
   
    addi $v0, $v0, 0
   
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra
   
min:
    slt $t0, $a0, $a1
    beq $t0, $0, min2
    slt $t0, $a0, $a2
    beq $t0, $0, min1
    addi $v0, $a0, 0
    jr $ra
   
min2:
    slt $t0, $a1, $a2
    beq $t0, $0, min1
    addi $v0, $a1, 0
    jr $ra
min1:
    addi $v0, $a2, 0
    jr $ra