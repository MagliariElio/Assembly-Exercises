.data 
	N: .word 10
	Stampa: .asciiz "Il valore corrispondente di Fibonacci e': "
	
.text
	
main: 
	la $a0, N 
	lw $a0, 0($a0)
	
	addi $sp, $sp, -4 
	sw $ra 0($sp)
	
	jal fib 
	
	add $s0, $0, $v0 
	lw $ra,0($sp)
	add $sp, $sp, 4
	
	la $a0, Stampa
	addi $v0, $0, 4
	syscall
	
	add $a0, $0, $s0 
	addi $v0, $0, 1
	syscall 
	
	addi $v0, $0, 10
	syscall 

fib: 
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	add $s0, $0, $a0
	
	slti $t0, $a0, 3
	beq $t0, $0, Else
	
	addi $v0, $0, 1
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	add $sp, $sp, 12
	
	jr $ra 
	
	Else:
		add $a0, $s0, -1
		jal fib 
		
		add $s1, $s1, $v0 
		add $s0, $s0, -2 
		
		jal fib 
		
		add $v0, $v0, $s1 
		
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		add $sp, $sp, 12
		
		jr $ra
	