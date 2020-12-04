.data
buffer: .space 22
.text
	li $s6, 20
	li $s7, 10
	la $s0, buffer
	li $s1, 0
	li $s3, 0
start_read_char: 
	li $v0, 12
	syscall
	add $s1, $s0, $s3
	addi $s3, $s3, 1
	beq $s3, $s6, end
	beq $v0, $s7, print
	sb $v0, 0($s1)
	j start_read_char
end: 
	sb $v0, 0($s1)
	li $v0, 11
	li $a0, '\n'
	syscall
print: 
	li $v0, 11
	lb $a0, 0($s1)
	syscall
	beq $s1, $s0, exit
	sub $s1, $s1, 1
	j print
exit: