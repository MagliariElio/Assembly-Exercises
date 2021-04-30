.data 
	n: .word 3
	
.text

main:
	la $a0, n
	lw $a0, 0($a0)
	
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
	jal T
	
	add $a0, $v0, $0
	addi $v0, $0, 1
	syscall
	
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	jr $ra 
	
T:
	addi $t0, $0, 1
	slt $t0, $a0, $t0
	beq $t0, $0, Else
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
		
		add $a0, $v0, $0
		jal Max
		
		add $v0, $s1, $v0
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		addi $sp, $sp, 12
		jr $ra

Max:
	addi $t0, $0, 5
	slt $t1, $a0, $t0
	beq $t1, $0, Else_2
	add $v0, $0, $t0 
	jr $ra
	
	Else_2:
		add $v0, $0, $a0
		jr $ra
		
		