.data
A: .word 1,3,4,4,1,5,2 
test: .word 1
.text
#Assignment 1
	#li $s2, 1 # j 
	#li $s1, 0 # i
	#li $t1, 2 # x = 2
	#li $t2, 2 # y = 2
	#li $t3, 2 # z = 2
	#	slt $t0, $s1, $s2
		#bne $t0, $zero, else
	#	addi $t1, $t1, 1
	#	addi $t3, $zero,1
	#	j endif
	#else: 
	#	addi $t2, $t2, -1
	#	mul $t3, $t3, 2
	#endif: 
	
#Assignment 2
	#li $s4, 1
	#li $s5, 0
	#li $s1, -1
	#li $s3, 3
	#la $s2, A
	#loop:
	#	add $s1, $s1, $s4
	#	add $t1, $s1, $s1
	#	add $t1, $t1, $t1
	#	add $t1, $t1, $s2
	#	lw  $t0, 0($t1)
	#	add $s5, $s5, $t0
	#	bne $s1, $s3, loop
		
#Assignment 3
	#la $s0, test
	#lw $s1, 0($s0)
	#li $t0, 0
	#li $t1, 1
	#li $t2, 2
	#beq $s1, $t0, case_0
	#eq $s1, $t1, case_1
	#beq $s1, $t2, case_2
	#j default
#ase_0: addi $s2, $s2, 1
	#j continue
#case_1: sub $s2, $s2, $t1
	#j continue
#case_2: add $s3, $s3, $s3
#	j continue
#default:
#continue:
	
#Assigntment 4a
	#blt $s1, $s2, else
#Assigntment 4b
	#ble $s2, $s1, else
#Assigntment 4c
	#addi $s3, $s1, $s2
	#ble $s3, $zero, else
#Assignment 4d
	#addi $s3, $s1, $s2 #s3 = x+y
	#addi $s4, $s5, $s6 #s4 = m+n
	#blt $s4, $s3, else
#Assignment 5a
	#blt 	$s1, $s3, loop
#Assginment 5b
	#ble	$s1, $s3, loop
#Assginment 5c
	#bge	$s3, $zero, loop
#Assginment 5d
	#bne 	$t0, $zero, loop
#Assignment 6
	li $s4, 1
	li $s1, -1
	li $s3, 5
	la $s2, A
	loop:
		add $s1, $s1, $s4
		add $t1, $s1, $s1
		add $t1, $t1, $t1
		add $t2, $t1, 4
		add $t1, $t1, $s2
		add $t2, $t2, $s2
		lw  $t0, 0($t1)
		lw  $t5, 0($t2)
		if: 
			blt $t5, $t0, else
			add $t6, $t5, $zero
		else: blt $s1, $s3, loop

		
