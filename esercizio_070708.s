.data 
	n: .word 7

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
	add $t1, $0, $0          # $t1 indice i
	
	
	For:
		beq $t1, $a0, Stop
		addi $sp, $sp, -16
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $t1, 8($sp)
		sw $t4, 12($sp)
		
		add $a0, $t1, $0           # $a0 = i
		
		jal F
		
		add $t4, $t4, $v0         # ermenegildo
		
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $t1, 8($sp)
		lw $t4, 12($sp)
		addi $sp, $sp, 16
		
		addi $t1, $t1, 1         # i += 1
		j For
	Stop:
		add $v0, $0, $t4        # return ermenegildo
		jr $ra

F:
	addi $t0, $0, 2                    # $t0 = 2
	slt $t1, $a0, $t0                  # if(i < 2) ? return 1 : goto Else 
	beq $t1, $0, Else
	addi $v0, $0, 1
	jr $ra
	
	Else:
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		
		add $s0, $a0, $0            # $s0 = i
		addi $a0, $s0, -1           # $a0 = $s0 - 1
		
		jal F
		
		add $s1, $0, $v0            # bob = $v0 
		
		addi $a0, $s0, -2           # $a0 = i-2
		jal F
		
		mult $s1, $v0             # $v0 * bob
		mflo $v0                  
		addi $v0, $v0, 1          # $v0 += 1
		
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		addi $sp, $sp, 12
		jr $ra
		
