.data
test2: .asciiz "The sum of " 
test2_1: .asciiz " and "
test2_2: .asciiz " is "
.text
	li $s0, 1
	li $s1, 2
	add $s2, $s1, $s0
	li $v0, 4
	la $a0, test2 
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, test2_1 
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, test2_2
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall