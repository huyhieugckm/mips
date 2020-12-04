.data
.eqv 	HEADING	 	0xffff8010
.eqv 	MOVING	 	0xffff8050
.eqv 	LEAVETRACK	0xffff8020
.eqv 	WHEREX		0xffff8030
.eqv	WHEREY		0xffff8040
.text
main:
	addi $a0, $zero, 180
	jal ROTATE
	jal GO
	li $v0, 32
	li $a0, 5000
	syscall
goRIGHT:
	addi $a0, $zero, 90
	jal ROTATE
	li $v0, 32
	li $a0, 5000
	syscall
	jal UNTRACK
	jal TRACK
draw:
	addi $a0, $zero, 210
	jal ROTATE
	li $v0, 32
	li $a0, 6000
	syscall
	jal UNTRACK
	jal TRACK
draw2:
	addi $a0, $zero, 90
	jal ROTATE
	li $v0, 32
	li $a0, 6000
	syscall
	jal UNTRACK
	jal TRACK
draw3:
	addi $a0, $zero, 330
	jal ROTATE
	li $v0, 32
	li $a0, 6000
	syscall
	jal UNTRACK
draw4:
	addi $a0, $zero, 90
	jal ROTATE
	li $v0, 32
	li $a0, 500
	syscall
	J STOP
end_main:
GO:
	li $at, MOVING
	addi $k0, $zero, 1
	sb $k0, 0($at)
	jr $ra
STOP:
	li $at, MOVING
	sb $zero, 0($at)
TRACK:
	li $at, LEAVETRACK
	addi $k0, $zero, 1
	sb $k0, 0($at)
	jr $ra
UNTRACK:
	li $at, LEAVETRACK
	sb $zero, 0($at)
	jr $ra
ROTATE:
	li $at, HEADING
	sw $a0, 0($at)
	jr $ra
