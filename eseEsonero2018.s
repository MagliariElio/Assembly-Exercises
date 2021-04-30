#esercizio esonero 2018
.text
.globl main
main:
	lw $a0, i						#carico il valore in $a0
	
	f:	slti $t0, $a0 , 2 			#i < 2 $t0 = 1
		beq $t0, $0 ,pippo 			#caso ricorsivo F
		addi $v1,$0,1 				#risultato caso particolare di F
		jr $ra 						#return
		
		pippo:	addi $sp, $sp, -12
				sw $ra, 0($sp)
				sw $s0, 4($sp)
				sw $s1, 8($sp)
				add $s0, $0 ,$a0 	#$s0 = i
				sub $a0,$a0, 2		#i= i-2
				jal f				#richiamo ricorsivo 
				sll $s1, $v1,1 		#f(i-2)*2
				sub $a0, $s0,1      #i = i-1
				jal g
				sll $s2,$v1,2 		#g(i-1)*4
				add $v1,$s2,$v1		#(g(i-1)*4)+g(i-1)
				add $v1,$s0,$v1		#sommo i
				addi $v1,$v1,-3		#sottraggo 3
				lw $ra,0($sp)
				lw $s0,4($sp)
				lw $s1,8($sp)
				addi $sp, $sp, 12
				jr $ra
				
	g:	slti $t0,$a0,3				#i<3 $t0 = 1
		beq $t0, $0, pluto 			#if $t0==1 go to pluto
		addi $v1,$0,4				#caso base uguale 4
		jr $ra						#return 
		
		pluto:	addi $sp,$sp,-8
				sw $ra, 0($sp)
				sw $s0, 4($sp)
				add $s0,$0,$a0  	#$s0 = i
				addi $t1,$0,2		#$t1 = 2
				div $s0,$t1			#divisione per 2
				mflo	$a0			#carico in $a0 il risultato della divisione
				jal f
				add $s2,$v1,$0		#$s2 = risultato di f(i/2)
				addi $a0, $s0,-1	#i= i-1
				jal g
				add $s3,$v1,$0		#carico in $s3 il risultato di g(i-1)
				slt $t0,$s2,$s3		#se $s2<$s3 then $t0 = 1
				bne $t0,$0, else	#se $t0 = 1 go to else
				slt $t0,$s3,$s0		#if $s3<$s0 then $t0 = 1
				bne $t0,$0, else2	#if $t0 = 1 go to else2
				add $v1,$s0,$0		#risultato = $s0
				j 	exit	
				
			else:	
				slt $t0,$s2,$s0		#if $s2<$s0 then $t0 = 1
				bne $t0,$0,else3	#if $t0 = 1 go to else3
				add $v1, $s0,$0 	#risultato = $s0
				j exit
			
			else2:
				add $v1,$s3,$0		#risultato = $s3
				j exit 
				
			else3:
				add $v1,$s2,$0		#risultato = $s2
				j exit 
				
			exit: 
				lw $ra,0($sp)
				lw $s0,4($sp)
				addi $sp, $sp, 8
				jr $ra
				
.data	
	i: .word 3