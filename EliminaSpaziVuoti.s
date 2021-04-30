.data 
	pa: .asciiz "Corso di Calcolatori"
	space: .asciiz " "
.text 

main: 
	la $a1, pa
	addi $t0, $0, 19
	la $a2, space
	lb $s0, 0($a2)
	add $s1, $0, $0
	
	for:
		beq $t0, $s1, Exit
		add $t1, $a1, $s1
		lb $t2, 0($t1) 
		
		beq $s0, $t2, for2
		addi $s1, $s1, 1
		j for 

		
		for2: 
			beq $t0, $s1, Exit  
			add $t1, $a1, $s1
			lb $t2, 0($t1)
			addi $s1, $s1, 1
			beq $s0, $t2, for2
			
			add $t3, $a1, $s1
			addi $t3, $t3, -1
			addi $t4, $t3, -1
			
			lb $t5, 0($t3)
			sb $t5, 0($t4) 
			
			j for2
	
Exit: 
	add $a0, $a1, $0
	addi $v0, $0, 4
	syscall
	jr $ra 
			