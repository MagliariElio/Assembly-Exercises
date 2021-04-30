.globl main
main:
	lw $a0, n
	
	fib:
		addi $sp, $sp,-12
		
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		
		add $s0,$0,$a0
		slti $t0,$s0,2
		bne $t0,$0,else
		add $v1,$s0,$0
		lw $ra,0($sp)
		lw $s0,4($sp)
		lw $s1,8($sp)
		add $sp,$sp,12
		jr $ra
	else:
		addi $a0,$s0,-1
		jal fib
		add $s1,$0,$v1
		add $a0,$s0,-2
		jal fib
		add $v1,$v1,$s1
		jr $ra
			
	
	
	
.data 

	n: .word 4