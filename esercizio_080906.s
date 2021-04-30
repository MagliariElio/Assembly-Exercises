.data 
	A: .word 6 2 3 4 5 6 7 
	n: .word 7
	
.text

main:
	la $a0, A
	la $a1, n
	lw $a1, 0($a1)
	
	addi $sp, $sp ,-12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	
	jal F
	
	add $a0, $v0, $0
	addi $v0, $0, 1
	syscall
	
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12
	jr $ra

F:
	addi $a1, $a1, -2      # n -= 2
	sll $a1, $a1, 2        # n *= 4
	add $t0, $0, $0        # indice i
	add $v0, $0, $0
	For:
		beq $t0, $a1, Stop
		
		add $t1, $a0, $t0     # $t1 = &A[i]
		lw $t1, 0($t1)        # $t1 = A[i]
		
		addi $t0, $t0, 4      # i += 1
		add $t2, $a0, $t0     # $t2 = &A[i+1]
		lw $t2, 0($t2)        # $t2 = A[i+1]
		
		beq $t1, $t2, JUMP    # if(A[i] == A[i+1]) ? summ : continue
		
		addi $t2, $t2, 11     # A[i+1] += 11
		
		slt $t3, $t1, $t2     # if(A[i] <= A[i+1]+10) ? sum : jump For
		bne $t3, $0, JUMP 
		
		j For
		
		JUMP:
			add $v0, $v0, $t1
			j For 
			

Stop:
	jr $ra 
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		