.data
Message: .asciiz "Key scan code "
.eqv IN_ADRESS_HEXA_KEYBOARD	0xffff0012
.eqv OUT_ADRESS_HEXA_KEYBOARD	0xffff0014
.text
	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t3, 0x80
	sb $t3, 0($t1)
	xor $s0, $s0, $s0
Loop:
	addi $s0, $s0, 1
	#li $v0, 1
	#add $a0, $s0, $zero
	#syscall
	beq $s0, 1000, end
	#li $v0, 11
	#li $a0, '\n'
	#syscall

	li $v0, 32
	li $a0, 300
	syscall
	nop
	b Loop
end:
	li $v0, 10
	syscall
.ktext 0x80000180
IntSR:
	addi $sp, $sp, 4
	sw $ra, 0($sp)
	addi $sp, $sp, 4
	sw $at, 0($sp)
	addi $sp, $sp, 4
	sw $v0, 0($sp)
	addi $sp, $sp, 4
	sw $a0, 0($sp)
	addi $sp, $sp, 4
	sw $t1, 0($sp)
	addi $sp, $sp, 4
	sw $t3, 0($sp)
	li $v0, 4
	la $a0, Message
	syscall
	
	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t3, 0x88
	sb $t3, 0($t1)
	li $t2, OUT_ADRESS_HEXA_KEYBOARD
	lb $a0, 0($t2)
	beq $a0, 0x18, print
	beq $a0, 0x28, print
	beq $a0, 0x48, print
	beq $a0, 0xffffff88, print
	
	li $t3, 0x18
	sb $t3, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x11, print
	beq $a0, 0x21, print
	beq $a0, 0x41, print
	beq $a0, 0xffffff81, print
	
	li $t3, 0x28
	sb $t3, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x12, print
	beq $a0, 0x22, print
	beq $a0, 0x42, print
	beq $a0, 0xffffff82, print

	li $t3, 0x48
	sb $t3, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x14, print
	beq $a0, 0x24, print
	beq $a0, 0x44, print
	beq $a0, 0xffffff84, print
PC:
	mfc0 $at, $14
	addi $at, $at, 4
	mtc0 $at, $14
restore:
	lw $t3, 0($sp)
	addi $sp, $sp, -4
	lw $t1, 0($sp)
	addi $sp, $sp, -4
	lw $a0, 0($sp)
	addi $sp, $sp, -4
	lw $v0, 0($sp)
	addi $sp, $sp, -4
	lw $ra, 0($sp)
	addi $sp ,$sp, -4
	eret
print:
	li $v0, 34
	syscall
	li $v0, 11
	li $a0, '\n'
	syscall
	j PC