.data
	A: .word 1 2 3 4 5 6 7
	B: .word 0 0 0 0 0 0 0
	n: .word 7
	
.text

main:
	la $a0, A
	la $a1, B
	la $a2, n
	lw $a2, 0($a2)
	
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	
	jal F
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 12
	
	jr $ra
	
F:
	add $t0 ,$0, $0           # indice i
	sll $a2, $a2, 2           # n *= 4
	
	For:
		beq $t0, $a2, Stop        # (i == n) ? goto Stop : continue
		add $t2, $0, $0           # indice j
		add $t4, $0, $0           # count = 0
		addi $t0, $t0, 4
		For_2:
			beq $t2, $t0, Continue
			add $t3, $a0, $t2            # $t3 = &A[j]
			lw $t3, 0($t3)               # $t3 = A[j]
			add $t4, $t3, $t4            # count += A[j]
			addi $t2, $t2, 4             # j += 1
			j For_2
		
		Continue:
			addi $t0, $t0, -4
			add $t1, $a1, $t0     # $t1 = &B[i]
			lw $t2, 0($t1)        # $t2 = B[i]
			add $t4, $t4, $t2     # $t4 = count + B[i]
			sw $t4, 0($t1)        # B[i] = count
			addi $t0, $t0, 4      # i += 1
			j For
			
Stop:
	jr $ra