.data
.text
	li $a0, 8
	li $a1, 6
	li $a2, 12
	jal max
	add $s0, $zero, $v0
	li $v0, 10
	syscall
max: 
	add $v0, $a0, $zero
	sub $t0, $a1, $v0
	bltz $t0, okay 
	add $v0, $a1, $zero
okay: 
	sub $t0, $a2, $v0
	bltz $t0, done
	add $v0, $a2, $zero
done: 
	jr $ra	
