.data 
	BASE: .word 1 2 3 4 5 6 7 8 9
	LEN: .word 9
	True: .asciiz "La sequenza di numeri e' crescente!"
	Not: .asciiz "La sequenza non e' crescente!"
	
.text

main:
	la $a0, BASE     #$a0 = &BASE
	la $a1, LEN
	lw $s0, 0($a1)     #$s0 = LEN  
	addi $s0, $s0, -2
	sll $s0, $s0, 2
	add $t0, $t0, 0    # $t0 = index
	
	for: 
		beq $t0, $s0, Exit     # if index == LEN-1 goto Exit    
		
		add $a1, $a0, $t0    
		lw $t1, 0($a1)	      # load the number LEN in $t1  
		
		addi $t0, $t0, 4     
		add $a1, $a0, $t0
		lw $t2, 0($a1)        # load the number LEN-1 in $t2
		
		slt $t3, $t1, $t2     # if BASE[$t0] > BASE[$t0+1] goto NOT 
		beq $t3, $0, NOT  	
		j for 
	
Exit:
	la $a0, True          # It's a growing sequence  
	ori $v0, $0, 4        
	syscall 
	ori $v0, $0, 10 
	syscall 
	
NOT:
	la $a0, Not          # It's not a growing sequence 
	ori $v0, $0, 4
	syscall
	ori $v0, $0, 10 
	syscall 