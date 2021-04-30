.data
	A: .word 1 2 3 4 15 6 7 8 9
	n: .word 3

.text

main:
	la $a0, A
	la $a1, n
	lw $a1, 0($a1)

	add $s2, $0, $a1           
	addi $s2, $s2, 1            
	sll $s2, $s2, 2             
 
	add $sp, $sp, -4
	sw $ra, 0($sp)

	jal somma
	add $a0, $0, $v0
	add $v0, $0, 1
	syscall 

	lw $ra, 0($sp)
	add $sp, $sp, 4

	addi $v0, $0, 10
	syscall

somma: 
	add $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	add $s0, $a0, $0
	slti $t0, $a1, 1            
	beq $t0, $0, Else 
	
	add $v0, $0, $0
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	add $sp, $sp, 12
	jr $ra 
	
	Else:
	
		add $a0, $0, $s0
		add $t0, $a0, $s3
		lw $s1, 0($t0)
		addi $a1, $a1, -1 
		add $s3, $s3, $s2
		
		jal somma 
		
		add $v0, $v0, $s1
		
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		add $sp, $sp, 12
		
		jr $ra 
	