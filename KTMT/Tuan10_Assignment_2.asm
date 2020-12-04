.data
.eqv MONITOR_SCREEN 0x10010000
.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00
.eqv BLUE 0x000000FF
.eqv WHITE 0x00FFFFFF
.eqv YELLOW 0x00FFFF00
.eqv ORANGE 0x00FF6600
.text
	li $k0, MONITOR_SCREEN
	add $s0, $zero, $zero
	addi $s7, $zero, 8	
while1:	
	bge $s0, $s7, incot2
	li $t0, YELLOW
	sw $t0, ($k0)
	li $t0, YELLOW
	add $k0, $k0, 4
	sw $t0, ($k0)
	add $k0, $k0, 28
	add $s0, $s0, 1
	li $v0, 32
	la $a0, 300
	syscall
	j while1
incot2:
	li $k0, MONITOR_SCREEN
	add $s0, $zero, $zero
	addi $s7, $zero, 8
	add $k0, $k0, 24
while2:
	bge $s0, $s7, inhang
	li $t0, YELLOW
	sw $t0, ($k0)
	li $t0, YELLOW
	add $k0, $k0, 4
	sw $t0, ($k0)
	add $k0, $k0, 28
	add $s0, $s0, 1
	li $v0, 32
	la $a0, 300
	syscall
	j while2
inhang:	
	li $k0, MONITOR_SCREEN
	add $s0, $zero, $zero
	addi $s7, $zero, 4
	add $k0 $k0, 104
while3:
	bge $s0, $s7, end
	li $t0, YELLOW
	sw $t0, ($k0)
	li $t0, YELLOW
	add $k0, $k0, 32
	sw $t0, ($k0)
	sub $k0, $k0, 28
	add $s0, $s0, 1
	li $v0, 32
	la $a0, 300
	syscall
	j while3
end:
	li $v0, 10
	syscall