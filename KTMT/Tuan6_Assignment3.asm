.data
A: .word 5,3,2,4,1
.text
	li $t1, 5
loop: 
	subi $a1, $t1, 1
	blez $a1, done
	la $a0, A
	li $t2, 0
	jal pass_loop
	beqz $t2, done
	subi $t1, $t1, 1
	b loop
done: 	j end
pass_loop:
	lw $s1, ($a0)
	lw $s2, 4($a0)
	bgt $s1, $s2, swap
next: 
	addi $a0, $a0, 4
	subi $a1, $a1, 1
	bgtz $a1, pass_loop
	jr $ra
swap: 
	sw $s1, 4($a0)
	sw $s2, 0($a0)
	li $t2, 1
	j next
end: 
	li $v0, 10
	syscall