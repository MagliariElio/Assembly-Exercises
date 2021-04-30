.data 
	A: .word 1 2 3 4 5 6 7 8 9 
	B: .word 1 1 1 1 1 1 1 1 1 
	n: .word 9
	value: .asciiz "i valori di B sono: "
	
.text 

main: 
	la $a0, A                    # load indirizzo di A in $a0 
	la $a1, B 
	la $a2, n
	lw $a2, 0($a2)
	sll $a2, $a2, 2              # n = n*4 
	
	add $s0, $0, $0              #indice i
	for:
		slt $t0, $s0, $a2 
		beq $t0, $0, Print 
		
		add $t4, $a1, $s0    
		lw $s2, 0($t4)           # $s2 = B[i]
		add $t1, $0, $0          # indice j 
		addi $t5, $s0, 4 
		
		for2:
			slt $t0, $t1, $t5      # if j > i goto inc 
			beq $t0, $0, inc 
			
			add $t3, $a0, $t1 
			lw $s1, 0($t3)         # $s1 = A[j]
			
			add $s2, $s2, $s1      # B[i] = A[j]         
			
			addi $t1, $t1, 4       # j += 4
			j for2 
		
		inc:
		sw $s2, 0($t4)
		add $s2, $zero, $zero
		addi $s0, $s0, 4           # i += 4
		j for 


Print:
	add $s0, $0, $0
	la $a0, value
	addi $v0, $0, 4
	syscall 
	
	for3:
		slt $t0, $s0, $a2 
		beq $t0, $0, Exit
		
		add $a1, $a1, $s0
		lw $a0, 0($a1)
		addi $v0, $0, 1
		syscall 
		
		addi $s0, $s0, 4
		j for3

Exit:
	addi $v0, $0, 10
	syscall