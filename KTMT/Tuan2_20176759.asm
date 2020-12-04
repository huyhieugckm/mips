.data
X: .word 5
Y: .word -1
Z: .word
.text
	#Assignment 1
	#addi $s0, $zero, 0x1AA7
	#add $s0, $zero, $0
	
	#Assignment 2
	#lui $s0, 0x2110
	#ori $s0, $s0, 0x003d
	
	#Assignment 3
	#li $s0, 0x2110003d
	#li $s1, 0x2
	
	#Asignment 4
	#addi $t1, $zero, 5
	#addi $t2, $zero, -1
	#add $s0, $t1, $t1
	#add $s0, $s0, $t2
	
	#Assignment 5
	#addi $t1, $zero, 4
	#addi $t2, $zero, 5
	#mul $s0, $t1, $t2
	#mul $s0, $s0, 3
	#mflo $s1
	
	#Assigntmet 6
	la $t8, X
	la $t9, Y
	lw $t1, 0($t8)
	lw $t2, 0($t9)
	
	add $s0, $t1, $t1
	add $s0, $s0, $t2
	
	la $t7, Z
	sw $s0, 0($t7)