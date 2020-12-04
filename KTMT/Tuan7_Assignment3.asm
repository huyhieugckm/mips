.data
.text
	li $s0, 8
	li $s1, 10
	addi $sp, $sp, -8
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8