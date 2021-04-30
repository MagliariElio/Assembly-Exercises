# Esercizio numero 1 del Tutoraggio anno 18/19
# Corrispondente della funzione scritta in C

.data 
	n: .asciiz "Inserire un intero positivo: "
	Error: .asciiz "Inserire un numero maggiore o uguale a zero"
	Risultato: .asciiz "Il risultato e': "

.text 

main:
	la $a0, n            
	ori $v0, $0, 4        # printf("Inserire un numero maggiore o uguale a zero")
	syscall 
	
	ori $v0, $0, 5 
	syscall 
	
	add $s0, $0, $v0     # $s0 = n
	
	slti $t0, $s0, 0     # if $s0 < 0 ritorna Errore
	bne $t0, $0, Exit 
	
	jal function
	add $t0, $v0, $0    # pongo il valore di $v0 in $t0 temporaneamente 
	
	la $a0, Risultato
	ori $v0, $0, 4
	syscall
	
	add $a0, $0, $t0    # stampo a video il risultato della funzione 
	ori $v0, $0, 1
	syscall 
	
	ori $v0, $0, 10     # fine della funzione
	syscall 

Exit:
	la $a0, Error 
	
	ori $v0, $0, 4
	syscall 
	
	add $v0, $0, 10
	syscall 

function:
	addi $sp, $sp, -12     # alloco memoria 
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	addi $s0, $s0, -1      # n -= 1
	j min                  # calcolo il minimo che coservero' in $s1 
	continue:
	sw $s1, 8($sp)
	beq $s0, $0, Else
	jal function
	lw $ra, 0($sp)        # tiro fuori mano a mano tutto quello che ho conservato 
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	add $v0, $v0, 0       # T(n-1)
	addi $v0, $v0, 1      # T(n-1) += 1
	add $v0, $v0, $s1     # T(n-1) += min(n-1)
	addi $sp, $sp, 12     # dealloco memoria 
	jr $ra
	
	
Else:
	add $v0, $0, $0       # caso base in n == 0 allora $v0 = 0 
	jr $ra 				  # ritorno 

min:
	slti $t0, $s0, 10     # controllo se n < 10 se cosi fosse min = $s0 
	beq $t0, $0, Oppure   
	add $s1, $s0, $0  
	jr continue           # continuo il procedimento 
	Oppure:
		addi $s1, $0, 10   # altrimenti min = 10 
		jr continue     
	
	