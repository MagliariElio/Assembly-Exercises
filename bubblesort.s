.data
	A: .word 1 2 5 3 7 4 8 6
	n: .word 8
	
.text

main:
	la $a0, A
	la $a1, n
	lw $a1, 0($a1)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal bubblesort 
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra 
	
bubblesort:
	addi $a1, $a1, -1             #n -= 1
	sll $a1, $a1, 2               #n *= 4
	add $t3, $a1, $0              #$t3 = (n-1) * 4
	bubble:
		addi $t0, $0, -4          
		bne $a1, $t0, else        #if((n-1) != -1) goto else 
		jr $ra 
		
		else:
			addi $sp, $sp, -8
			sw $ra, 0($sp)
			sw $s0, 4($sp)
			
			add $s0, $a0, $a1       #$s0 = &A[n-1]
			lw $s0, 0($s0)          #$s0 = A[n-1]
			
			add $t0, $0, $0         #i = 0
			for:
				beq $t0, $a1, continue   #if(i == n-1) goto continue 
				
				add $t1, $a0, $t0        #$t1 = &A[i]
				lw $t1, 0($t1)
				
				slt $t2, $s0, $t1        #if(A[n-1]<A[i]){$s0 = A[n-1]} else{$s0 = A[i]}  
				addi $t0, $t0, 4         #i++
				bne $t2, $0, for
				
				add $t0, $t0, -4
				add $t4, $a0, $t0        #$t4 = &A[i]
				add $t5, $a0, $a1        #$t5 = &A[n-1]
				
				sw $s0, 0($t4)
				sw $t1 , 0($t5)
				addi $t0, $t0, 4 
				
				add $s0, $0, $t1
				j for 
				
			continue:
				addi $a1, $a1, -4            #n -= 1
			
				jal bubble
			
				add $t0, $a0, $t3       #$t0 = &A[n-1]
				sw $s0, 0($t0)          #A[n-1] = $s0
				addi $t3, $t3, -4       #n -= 1
			
				lw $ra, 0($sp)
				lw $s0, 4($sp)
				addi $sp, $sp, 8
			
				jr $ra 