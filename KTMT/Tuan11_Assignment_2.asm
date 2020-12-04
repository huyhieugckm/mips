.data
Message: .asciiz "Oh my god. Someone's is pressed a button. \n"
.eqv IN_ADRESS_HEXA_KEYBOARD	0xffff0012
.eqv OUT_ADRESS_HEXA_KEYBOARD	0xffff0014
.text	
	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t7, 0x80
	sb $t7, 0($t1)
Loop:
	nop
	nop
	nop
	nop
	b Loop
.ktext	0x80000180
IntSR:
	addi $v0, $zero, 4
	la $a0, Message
	syscall
	mfc0 $at, $14
	addi $at, $at, 4
	mtc0 $at, $14
	eret






