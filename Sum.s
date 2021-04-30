#Somma di valori all'interno di un array
.data 
array: .word 1,2,3,4,5,6,7,8,9,10    #componenti dell'array

.text
.globl main

main:
	addi $s1, $s1, 10      #lunghezza dell'array
	la $s0, array          #carico l'array
	add $t0, $t0, $zero    #sum
	add $t1, $t1, $zero    #indice
	add $t3, $t3, $zero    #accesso per l'array

loop:        
	lw $t2, $t3($s0)         #prendo il primo elemento
	add $t0, $t0, $t2      #somma 
	addi $t3, $t3, 4       #aumento dell'indice nell'array
	addi $t1 $t1, 1        #aumento del contatore del ciclo 
	bne $t1, $s1, loop     #if $t1 == 10  
	syscall
