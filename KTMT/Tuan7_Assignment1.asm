.data
.text
	li $a1, 5
	jal abs
	add $a0, $zero, $v0
	li $v0, 10
	syscall
abs: 
	sub $v0, $zero, $a1
	bltz $a1, done
	add $v0, $a1, $zero
done:
	jr $ra