#reduce run speed to 25inst/sec before run this program
.data
.eqv IN_ADRESS_HEXA_KEYBOARD	0xffff0012
.eqv OUT_ADRESS_HEXA_KEYBOARD	0xffff0014
.eqv SEVENSEG_LEFT	0xFFFF0011
.eqv SEVENSEG_RIGHT	0xFFFF0010
.text
	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t2, OUT_ADRESS_HEXA_KEYBOARD
	li $t3, 0x08
	li $t4, 0x04
	li $t5, 0x02
	li $t6, 0x01
	
polling: 
	li $a0, 0
	sb $t6, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x11, print0
	beq $a0, 0x21, print1
	beq $a0, 0x41, print2
	beq $a0, 0xffffff81, print3

	sb $t5, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x12, print4
	beq $a0, 0x22, print5
	beq $a0, 0x42, print6
	beq $a0, 0xffffff82, print7
	
	sb $t4, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x14, print8
	beq $a0, 0x24, print9
	beq $a0, 0x44, printa
	beq $a0, 0xffffff84, printb
	
	sb $t3, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x18, printc
	beq $a0, 0x28, printd
	beq $a0, 0x48, printe
	beq $a0, 0xffffff88, printf
	li $a0, 100
	li $v0, 32
	syscall
	j polling
print0:
	li $a0, 0x3F
	jal SHOW_LEFT
	li $a0, 0x3F
	jal SHOW_RIGHT
	j polling
print1:
	li $a0, 0x3F
	jal SHOW_LEFT
	li $a0, 0x6
	jal SHOW_RIGHT
	j polling	
print2:
	li $a0, 0x3F
	jal SHOW_LEFT
	li $a0, 0x5B
	jal SHOW_RIGHT
	j polling
print3:
	li $a0, 0x3F
	jal SHOW_LEFT
	li $a0, 0x4F
	jal SHOW_RIGHT
	j polling	
print4:
	li $a0, 0x3F
	jal SHOW_LEFT
	li $a0, 0x66
	jal SHOW_RIGHT
	j polling
print5:
	li $a0, 0x3F
	jal SHOW_LEFT
	li $a0, 0x6D
	jal SHOW_RIGHT
	j polling
print6:
	li $a0, 0x3F
	jal SHOW_LEFT
	li $a0, 0x7D
	jal SHOW_RIGHT
	j polling
print7:
	li $a0, 0x3F
	jal SHOW_LEFT
	li $a0, 0x7
	jal SHOW_RIGHT
	j polling
print8:
	li $a0, 0x3F
	jal SHOW_LEFT
	li $a0, 0x7F
	jal SHOW_RIGHT
	j polling
print9:
	li $a0, 0x3F
	jal SHOW_LEFT
	li $a0, 0x6F
	jal SHOW_RIGHT
	j polling
printa:
	li $a0, 0x6
	jal SHOW_LEFT
	li $a0, 0x3F
	jal SHOW_RIGHT
	j polling
printb:
	li $a0, 0x6
	jal SHOW_LEFT
	li $a0, 0x6
	jal SHOW_RIGHT
	j polling
printc:
	li $a0, 0x6
	jal SHOW_LEFT
	li $a0, 0x5B
	jal SHOW_RIGHT
	j polling
printd:
	li $a0, 0x6
	jal SHOW_LEFT
	li $a0, 0x4F
	jal SHOW_RIGHT
	j polling
printe:
	li $a0, 0x6
	jal SHOW_LEFT
	li $a0, 0x66
	jal SHOW_RIGHT
	j polling
printf:
	li $a0, 0x6
	jal SHOW_LEFT
	li $a0, 0x6D
	jal SHOW_RIGHT
	j polling
SHOW_RIGHT:
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	li $v0, 32
	li $a0, 1000
	syscall
	jr $ra
SHOW_LEFT:
	li $t0, SEVENSEG_LEFT
	sb $a0, 0($t0)
	jr $ra
