.data 
	Word: .asciiz "i topi non avevano nipoti"
	True: .asciiz "True"
	False: .asciiz "False"
	
.text

main:
	la $a0, Word
	
	add $a1, $0, $0					# $a1 contatore x
	For:	
		add	$t0, $a1, $a0			# $t0 = &A[x] 
		lb $t0, 0($t0)				# $t0 = A[x]
		beq $t0, $0, End			# if(A[x] == '\0') goto End
		addi $a1, $a1, 1
		j For
	
	End:
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		
		jal Palindroma			
		
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		addi $sp, $sp, 12
		jr $ra
	
Palindroma:
	add $t0, $0, $0					# $t0 indice x
	addi $a1, $a1, -1				# $a1 = contatore - 1
	add $t1, $a1, $0				# len = $a1
	Pal:
		slt $t2, $t1, $t0			# if(len > x) goto Else 	
		beq $t2, $0, Else
		la $a0, True	
		add $v0, $0, 4
		syscall
		jr $ra
		
	Else:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		LOOP:
			addi $t4, $0, 32			# $t4 = 32				32 = spazio
			add $t2, $t0, $a0			# $t2 = &Word[x]
			lb $t2, 0($t2)				# $t2 = Word[x]
			bne $t4, $t2, LOOP2			# if(32 != Word[x])
			addi $t0, $t0, 1			# x++
			j LOOP
			
		LOOP2:
			add $t3, $t1, $a0			# $t3 = &Word[len]
			lb $t3, 0($t3)				# $t3 = Word[len]
			addi $t4, $0, 32			
			bne $t4, $t3, continue
			sub $t1, $t1, 1
			j LOOP2
			
		continue:
			bne $t2, $t3, Stop			# if(Word[x] != Word[len]) goto Stop
			
			addi $t0, $t0, 1			# x++
			sub $t1, $t1, 1				# len--				
			
		jal Pal
		
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		
Stop:
	la $a0, False
	addi $v0, $0, 4
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra