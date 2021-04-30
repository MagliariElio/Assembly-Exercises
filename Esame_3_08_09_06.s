.data 
	A: .word 22 12 0 0 5 5 0 0
	n: .word 8

.text

main:
	la $a0, A
	la $a1, n
	lw $a1, 0($a1)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal somma
	
	add $a0, $v0, $0
	addi $v0, $0, 1
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
somma:
	add $t0, $0, $0     #indice i
	add $a1, $a1, -1    #n -= 1
	sll $a1, $a1, 2
	sum: 
		bne $t0, $a1, else    #if i<n-1 goto else 
		add $v0, $0, $0
		jr $ra
		
		else:
			addi $sp, $sp, -8
			sw $ra, 0($sp)
			sw $s0, 4($sp)
			
			add $s0, $0, $0       #$s0 = 0
			add $t1, $a0, $t0     #$t1 = &A[i]
			lw $t1, 0($t1)
		
			addi $t0, $t0, 4      #i++
			add $t2, $a0, $t0     #$t2 = &A[i+1]
			lw $t2, 0($t2)        #$t2 = A[i+1]
		
			beq $t1, $t2, continue     #if(A[i] == A[i+1]) goto continue 
		
		
			addi $t2, $t2, 11     #A[i+1] += 11
		
			slt $t3, $t1, $t2     #if not (A[i] <= A[i+1]+10) goto sum
			beq $t3, $0, sum
		
			continue:
				add $s0, $t1, $0 
				jal sum 
				add $v0, $v0, $s0     #$v0 += $s0
		
				lw $ra, 0($sp)
				lw $s0, 4($sp)
				addi $sp, $sp, 8
		
				jr $ra