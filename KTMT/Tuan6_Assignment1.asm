.data
A: .word -2, 6, -1, 3, -2
.text

	la $a0, A
	li $a1, 5
	j mspfx
continue: 
#lock: 	j lock
mspfx: 	addi $v0, $zero, 0
	addi $v1, $zero, 0
	addi $t0, $zero, 0
	addi $t1, $zero, 0
loop: 	add $t2, $t0, $t0
	add $t2, $t2, $t2
	add $t3, $t2, $a0
	lw $t4, 0($t3)
	add $t1, $t1, $t4
	slt $t5, $v1, $t1
	bne $t5, $zero, mdfy
	j test
mdfy: 	addi $v0, $t0, 1
	addi $v1, $t1, 0
test:	addi $t0, $t0, 1
	slt $t5, $t0, $a1
	bne $t5, $zero, loop
done: 	li $v0, 10
	syscall
	#j continue
mspfx_end: 