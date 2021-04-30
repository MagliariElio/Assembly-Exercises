.globl main

.data
	numero: .asciiz "Inserisci un numero: "
	carattere: .asciiz "Inserisci dei caratteri: " 
	stampa: .asciiz "Il numero : "
	risultato: .asciiz "Il risultato della sommma tra i due numeri : "
	car: .word 2

.text 

main:

	#CHIEDO IL PRIMO NUMERO
	la $a0, numero
	li $v0, 4
	syscall
	
	#LEGGO IL NUMERO
	li $v0, 5
	syscall
	
	#LO SPOSTO IN UN ALTRO REGISTRO
	move $t0, $v0

	#CHIEDO IL SECONDO NUMERO
	la $a0, numero
	li $v0, 4
	syscall
	
	#LEGGO IL NUMERO
	li $v0, 5
	syscall
	
	#LO SPOSTO IN UN ALTRO REGISTRO
	move $t1, $v0
	
	#CHIEDO IL CARATTERE 
	la $a0, carattere
	li $v0, 4
	syscall
	
	#LEGGO IL CARATTERE
	la $a0, car
	li $v0, 8
	syscall
	
	#LO SPOSTO IN UN ALTRO REGISTRO
	move $t2, $v0
	
	#PRINTO IL PRIMO NUMERO INSERITO
	move $a0, $t0
	li $v0, 1
	syscall
	
	#PRINTO IL CARATTERE
	la $a0, car
	li $v0, 4
	syscall
	
	#PRINTO IL SECONDO NUMERO INSERITO
	move $a0, $t1
	li $v0, 1
	syscall
	
	#PRINTO IL CARATTERE 
	la $a0, car
	li $v0, 4
	syscall
	
	#FACCIO LA SOMMA E PRINTO
	add $t3, $t0, $t1
	la $a0, risultato
	li $v0, 4
	syscall
	move $a0, $t3
	li $v0, 1
	syscall
	
	#TERMINO IL PROGRAMMA
	li $v0, 10
	syscall