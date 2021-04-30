.data 
	n: .word 4
	parola: .asciiz "osso"
	false: .asciiz "False"
	true: .asciiz "True" 

main:
	la $a0, parola 
	la $a1, n
	lw $a1, 0($a1)

	addi $a1, $a1, -1
	
	srl $t4, $a1, 1
	addi $t4, $t4, 1 
	add $sp, $sp, -4
	sw $ra, 0($sp)
	jal Palindromo 
	la $a0, true
	addi $v0, $0, 4
	syscall
	lw $ra, 0($sp)
	add $sp, $sp, 4
	addi $v0, $0, 10
	syscall 

Palindromo:
	bne $a1, $t4, Else
	jr $ra 
	
	Else:
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		
		add $s0, $a1, $0
		
		addi $a0, $s0, -1 
		jal Palindromo 

		add $t2, $a0, $t0
		lw $t2, 0($t2)
		
		add $t3, $a0, $s0
		lw $t3, 0($t3)

		bne $t2, $t3, False
		addi $t0, $t0, 1
		
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		addi $sp, $sp, 8
		
		jr $ra 
	
False:
	la $a0, false
	addi $v0, $0, 4
	syscall
	addi $v0, $0, 1
	syscall
