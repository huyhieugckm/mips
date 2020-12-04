.data
test1: .asciiz  "Hello World"
.text

	li $v0, 4
	la $a0, test1
	syscall
	
	