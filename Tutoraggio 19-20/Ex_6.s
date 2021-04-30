.data 
	i: .word 3
	
.text 

main:
	la $a0, i 
	lw $a0, 0($a0)
	
	add $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal f
	add $a0, $0, $v0
	addi $v0, $0, 1
	syscall 
	
	lw $ra, 0($sp)
	add $sp, $sp, 4
	
	addi $v0, $0, 10
	syscall 
	
f: 
	add $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	add $s0, $a0, $0
	
	slti $t0, $a0, 2
	beq $t0, $0, Else 
	
	addi $v0, $0, 1
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	add $sp, $sp, 12
	jr $ra 
	
	Else: 
		addi $a0, $s0, -1
		jal f 
		add $s1, $s1, $v0 
		sll $s1, $s1, 1
		
		add $a0, $s0, -1 
		jal g 
		
		sll $v0, $v0, 1
		
		add $v0, $v0, $s0
		addi $v0, $v0, -3 
		
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		add $sp, $sp, 12
		
		jr $ra 
		
g: 
	add $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	add $s0, $a0, $0
	
	slti $t0, $a0, 3
	beq $t0, $0, Else2
	
	addi $v0, $0, 4
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	add $sp, $sp, 12
	jr $ra 
	
	Else2: 
		div $a0, 2
		mflo $a0 
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	