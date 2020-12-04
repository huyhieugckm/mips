.data
.text
#Assignment 1
	#start: 
	#	li $s1,12
	#	li $s2, 14
	#	li $t0, 0
	#	addu $s3, $s1, $s2
	#	xor $t1, $s1, $s2
	
	#	bltz $t1, EXIT
	#	slt $t2, $s3, $s2
	#	bltz $s1, NEGATIVE
	#	beq $t2, $zero, EXIT
	
	#	j OVERFLOW
	#NEGATIVE:
	#	bne $t2, $zero, EXIT
	#OVERFLOW: 
	#	li $t0, 1
	#EXIT:
	
#Assignment 2
	#Extract MSB	
		#li $s0, 0x12345678
		#andi $t0, $s0, 0xff000000
		#srl  $t0, $t0, 24
	#Clear LSB 
		#andi  $t0, $s0, 0xffffff00
	#Set	
		#or $t0, $s0, 0x0000ff
	#Clear $s0
		#and $s0, $s0, 0x0000000
		
#Assignment 3
#3a ABS
	#li $s1, -14 
	#sub $s0, $zero, $s1
	#ble $s0, $zero, done
	#j end
	#done: 
	#add $s0, $s1, $zero
	#end: 
#3b MOVE
	#li $s0, 10
	#li $s1, 11
	#addi $s0, $s1, 0
#3c NOT
	#li $s0, 0x000001
	#nor $s0, $s0, $s0 
#3d BLE	
	#li $s0, 12
	#li $s1, 11
	#slt $t0, $s0, $s1
	#bne $t0, $zero, done
	#done: 
#Assignmetn 4
	#start: 
	#	li $s1,12
	#	li $s2, 14
	#	li $t0, 0
	#	addu $s3, $s1, $s2
	#	xor $t1, $s1, $s2
	
	#	bltz $t1, EXIT
	#	xor $t2, $s3, $s1
	#	bltz $t2, OVERFLOW
	#j EXIT
	#OVERFLOW: 
	#	li $t0, 1
	#EXIT:

#Assignment 5
	#li $s0, 1
	#sll $s1, $s0, 1 #s1 = s0*2
	#sll $s1, $s0, 2 #s1 = s0*4
	#sll $s1, $s0, 3 #s1 = s0*8
	#sll $s1, $s0, 4	 #s1 = s0*16
	