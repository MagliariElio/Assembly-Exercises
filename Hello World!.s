.text 
.globl main

main:
	li $v0,4
	la $a0,string
	syscall
	li $v0,5 
	syscall
	jr $ra

.data 
string: .asciiz "Hello World!"