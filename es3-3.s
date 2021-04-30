.data 
	n: .word 5
	
.text

main: 
	la $a0, n 
	lw $a0, 0($a0) 
	
	addi $sp, $sp, -4 
	sw $ra, 0($sp) 
	
	jal T
	
	add $a0, $v0, $0
	addi $v0, $0, 1
	syscall 
	
	lw $ra,0($sp)
	addi $sp, $sp, 4 
	
	jr $ra

T:
	slt $t0, $0, $a0
	bne $t0, $0, Else 

	addi $v0, $0, 1
	jr $ra 

Else: 
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	add $s0, $a0, $0 
	
	addi $a0, $s0, -1 
	jal T 
	add $s1, $0, $v0 
	addi $a0, $s0, -2 
	jal T 
	slti $t0, $v0, 5 
	beq $t0, $0, True 
	addi $v0, $s1, 5
	j end 

True: 
	add $v0, $s1, $v0

end:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	add $sp, $sp, 12 
	jr $ra 