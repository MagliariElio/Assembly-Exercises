.text
.globl main

main:
	lw $t0,i  #indice del loop
	lw $t1,sum  #somma 

loop:
	beq $t0,10,exit #if $t0 == 10 jump exit
	add $t1, $t1, $t0
	addi $t0, $t0, 1
	j loop

exit:
	li $v0,10
	syscall

.data 
	i: .word 0
	sum: .word 17