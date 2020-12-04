.data
.eqv SEVENSEG_LEFT	0xFFFF0011
.eqv SEVENSEG_RIGHT	0xFFFF0010
.text
main:
	li $a0, 0x03F
	jal SHOW_7SEG_LEFT
	li $a0, 0x3F
	jal SHOW_7SEG_RIGHT
exit:
	li $v0, 10
	syscall
SHOW_7SEG_LEFT:
	li $t0, SEVENSEG_LEFT
	sb $a0, 0($t0)
	jr $ra
SHOW_7SEG_RIGHT:
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	li $a0, 0x6			# hien so 1
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	li $a0, 0x5B			# hien so 2
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	li $a0, 0x4F			# hien so 3
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	li $a0, 0x66			# hien so 4
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	li $a0, 0x6D			# hien so 5
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	li $a0, 0x7D			# hien so 6
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	li $a0, 0x7			# hien so 7
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	li $a0, 0x7F			# hien so 8
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	li $a0, 0x6F			# hien so 9
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	li $a0, 0x6			
	li $t0, SEVENSEG_LEFT
	sb $a0, 0($t0)
	li $a0, 0x3F			# hien so 10
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	jr $ra

	
