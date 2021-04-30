.data 
	A: .word 1 2 3 4 5 6 7
	B: .word 8 9 0 1 2 7 3
	C: .word 0 0 0 0 0 0 0 
	n: .word 7
	
.text

main:
	la $a0, A
	la $a1, B
	la $a2, C 
	la $a3, n
	lw $a3, 0($a3)
	
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	jal F

	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 20
	jr $ra
	
F:
	add $t0, $0, $0      # indice i
	sll $a3, $a3, 2      # n *= 4

	F_funct:
		bne $t0, $a3, Else
		jr $ra 
		
		Else:
			addi $sp, $sp, -28
			sw $ra, 0($sp)
			sw $a0, 4($sp)
			sw $a1, 8($sp)
			sw $a2, 12($sp)
			sw $a3, 16($sp)
			sw $t0, 20($sp)
			sw $s0, 24($sp)
			
			add $a1, $a1, $t0        # $a1 = &B[i]
			lw $a1, 0($a1)           # $a1 = B[i]
			add $a2, $a2, $t0        # $a2 = &C[i]
			lw $a2, 0($a2)           # $a2 = C[i]
			
			addi $s0, $0, -1
			mult $a2, $s0            # $a0 = C[i] * (-1)
			mflo $a0
			
			add $a0, $a1, $a0        # $a0 = B[i] - C[i]
			
			jal Max
			
			lw $a0, 4($sp)
			lw $t0, 20($sp)
			
			add $t1, $a0, $t0        # $t1 = &A[i]
			lw $t1, 0($t1)           # $t1 = A[i]
			add $v0, $v0, $t1        # summ = max + A[i]
			
			lw $a2, 12($sp)
			add $t2, $t0, $a2        # $t2 = &C[i]
			sw $v0, 0($t2)

			lw $ra, 0($sp)
			lw $a1, 8($sp)
			lw $a3, 16($sp)
			lw $s0, 24($sp)
			addi $sp, $sp, 28
			add $t0, $t0, 4         # i += 1
			j F_funct
			
Max:
	slt $t0, $a0, $0
	beq $t0, $0, Else_2
	
	add $v0, $0, $0
	jr $ra 
	
	Else_2:
		add $v0, $0, $a0
		jr $ra
			
			
			
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	