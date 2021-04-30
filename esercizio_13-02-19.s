.data
	n: .word 4

.text
.globl main

main:
	addi $sp, $sp, -4
	sw   $ra, 0($sp)

	la   $a0, n					   # $a0 = &n
	lw   $a0, 0($a0)		       # $a0 = n

	jal proc
	
	add $a0, $v0, $0
	addi $v0, $0, 1
	syscall
	
	lw 	 $ra 0($sp)
	addi $sp, $sp, 4
	jr 	 $ra

proc:
	slti $t0, $a0, 3				# $t0 = (i<3)
	beq  $t0, $zero, else			# if (i >= 3) goto else
	addi $v0, $zero, 1				# return 1
	jr   $ra

else:
	addi $sp, $sp, -8
	sw   $ra, 0($sp)
	sw   $s0, 4($sp)

	add  $s0, $a0, $zero 		   # $s0 = n
	add  $s1, $s1, $zero           # $s1 = i
	add  $s2, $s2, $zero           # $s2 = sum

loop:
	slt  $t1, $s1, $s0             # $t1 = (i<n)
	beq  $t1, $zero, exit 
	add  $a0, $s1, $zero           # $a0 = i
	jal proc                       # func(i)
	mult $s1, $v0                  # low = i*func(i)
	mflo $t2                       # $t2 = i*func(i)
	add  $s2, $s2, $t2             # $s2 = sum + i*func(i)
	addi $s1, $s1, 1               # i = i+1
	j loop

exit:
	add  $v0, $s2, $zero

	lw   $ra, 0($sp)
	lw   $s0, 4($sp)
	addi $sp, $sp, 8
	jr $ra


	

