
.eqv	SCREEN		0x10010000	
.eqv	BACKGROUND 	0x00000000
.eqv	KEY_A 		0x00000061
.eqv	KEY_S		0x00000073
.eqv	KEY_D		0x00000064
.eqv	KEY_W		0x00000077
.eqv	KEY_1		0x00000031
.eqv	KEY_2		0x00000032
.eqv	KEY_3		0x00000033
.eqv	KEY_4		0x00000034
.eqv	KEY_5		0x00000035
.eqv	KEY_ENTER	0x0000000a
.eqv	DELTA_X		5
.eqv	DELTA_Y		5
.eqv	DELAY_TIME	150
.eqv	KEY_CODE	0xFFFF0004
.eqv	KEY_READY	0xFFFF0000
.eqv	WHITE		0xFFFFFFFF
.eqv 	RED 		0x00FF0000
.eqv 	YELLOW 		0x00FFFF00
.eqv 	GREEN 		0x0000FF00
.data	
	CIRCLE_DATA: 	.space 512
	SQUARES_DATA:	.space 512
.macro addPoint(%r1, %r2, %r3)				#luu gia tri cac thanh ghi truoc do		
	add	$sp, $sp, -12
	sw	%r1, 0($sp) 
	sw 	%r2, 4($sp)
	sw 	%r3, 8($sp)
.end_macro

.macro addPosition(%r1, %r2, %r3, %r4)			
	add 	$sp, $sp, -16
	sw 	%r1, 0($sp)
	sw 	%r2, 4($sp)
	sw 	%r3, 8($sp)
	sw 	%r4, 12($sp)
.end_macro

.macro getPoint(%r1, %r2, %r3)
	lw 	%r1, 0($sp)
 	lw 	%r2, 4($sp)
 	lw 	%r3, 8($sp)
 	add 	$sp, $sp, 12
.end_macro

.macro getPosition(%r1, %r2, %r3, %r4)
	lw 	%r1, 0($sp)
 	lw 	%r2, 4($sp)
 	lw 	%r3, 8($sp)
 	lw 	%r4, 12($sp)
 	add 	$sp, $sp, 16
.end_macro

.macro deleteOldCircleDrawNewCircle(%color)	# xoa duong tron cu
	li 	$s5, %color		
 	jal 	drawCircle			
.end_macro 

.macro setColorAndDrawCirle(%r1)		#them ham ve hinh tron moi
	add $s5, $t9, $zero			#Dat mau 
 	jal drawCircle				#ve duong tron moi
.end_macro 

.macro branchIfLessOrEqual(%r1, %r2, %branch)	#check xem dap vao man hinh chua
	sle 	$v0, %r1, %r2	
 	bnez 	$v0, %branch
.end_macro
.macro deleteOldSquaresDrawNewSquares(%color)	# xoa hinh vuong cu
	li 	$s5, %color		
 	jal 	drawSquares			
.end_macro 

.macro setColorAndDrawSquares(%r1)		#them ham ve hinh vuong moi
	add $s5, $t9, $zero			#Dat mau 
 	jal drawSquares				#ve hinh vuong moi
.end_macro 
.text
main:
 	li	$s0, 256			# Toa do ban dau x0 = 256		
 	li 	$s1, 256			#  		 y0 = 256		
 	li 	$s2, 20				# Ban kinh R = 20 		
 	li 	$s3, 512			# Do rong man hinh SCREEN_WIDTH 512
 	li 	$s4, 512			# Do cao man hinh SCREEN_HEIGHT 512
 	li 	$s5, WHITE			# Mau duong tron
 	li 	$t9, WHITE		
 	mul 	$s6, $s2, $s2			# R^2
 	li 	$s7, DELTA_X			# delta x = 5
 	li 	$t8, 0				# delta y = 0
 
 	jal	startDrawCircle
 	
program:
readKeyboard:

 	lw 	$k1, KEY_READY
 	beqz 	$k1, checkPosition
 	nop
 	lw 	$k0, KEY_CODE
 	beq 	$k0, KEY_A, CASE_A
 	beq 	$k0, KEY_S, CASE_S
 	beq 	$k0, KEY_D, CASE_D
 	beq 	$k0, KEY_W, CASE_W
 	beq 	$k0, KEY_1, CASE_1
 	beq 	$k0, KEY_2, CASE_2
 	beq 	$k0, KEY_3, CASE_3
 	beq 	$k0, KEY_4, CASE_4
 	beq 	$k0, KEY_ENTER, CASE_ENTER
 	j 	checkPosition
 	
CASE_A:
 	jal 	moveToLeft
 	j 	checkPosition
 	
CASE_S:
 	jal 	moveToDown
 	j 	checkPosition
 	
CASE_D:
 	jal 	moveToRight
 	j 	checkPosition
 	
CASE_W:
 	jal 	moveToUp
 	j 	checkPosition
CASE_1:
	li 	$t9, RED
	j	readKeyboard
CASE_2:
	li 	$t9, YELLOW
	j	readKeyboard
CASE_3:
	li 	$t9, GREEN
	j	readKeyboard
CASE_4:
	deleteOldCircleDrawNewCircle(BACKGROUND)		#ve hinh tron mau nen
	setColorAndDrawSquares($t9)				#ve hinh vuong voi mau hien tai
	j 	program1					#ve hinh vuong
CASE_ENTER: 
 	j 	endProgram
 
 		
checkPosition:		
checkRightExtreme:

 	add 	$v0, $s0, $s2					# 
 	add 	$v0, $v0,$s7					# 
 	branchIfLessOrEqual($v0, $s3, checkLeftExtreme)	#
 	jal 	moveToLeft					# Neu x0 + R + DELTA_X > SCREEN_WIDTH -> moveToLeft
 	nop
 	
checkLeftExtreme:

 	sub 	$v0, $s0, $s2					#
 	add 	$v0, $v0, $s7					#
 	branchIfLessOrEqual($zero, $v0, checkTopExtreme)	# 	
 	jal 	moveToRight					# Neu x0 - R + DELTA_X < 0 -> moveToRight
 	nop
 	
checkTopExtreme:

 	sub 	$v0, $s1, $s2					#
 	add 	$v0, $v0, $t8					#
 	branchIfLessOrEqual($zero, $v0, checkBottomExtreme)	# 
 	jal 	moveToDown					# If y0 - R + DELTA_Y < 0 -> moveToDown
 	nop
 	
checkBottomExtreme:

 	add 	$v0, $s1, $s2					#
 	add 	$v0, $v0, $t8					#
 	branchIfLessOrEqual($v0, $s4, draw)			#
 	jal 	moveToUp					# Neu y0 + R + DELTA_Y > SCREEN_HEIGHT -> moveToUp
 	nop
 	
#-------------------------------------------------------------------------------------------------------------------
#	Xoa duong tron cu va ve duong tron moi
#-------------------------------------------------------------------------------------------------------------------

draw: 	
 	deleteOldCircleDrawNewCircle(BACKGROUND) 	# Ve duong tron trung mau nen
 	add 	$s0, $s0, $s7				# 
 	add 	$s1, $s1, $t8				# Cap nhat toa do moi cua duong tron
 	
 	setColorAndDrawCirle($t9)			# Ve duong tron moi
 	
 	li 	$a0, DELAY_TIME
 	li 	$v0, 32
 	syscall						# Delay chuong trinh 1 khoang thoi gian
 	
 	j 	program
 	
endProgram:

	deleteOldCircleDrawNewCircle(BACKGROUND)
 	li 	$v0, 10
 	syscall
#-------------------------------------------------------------------------------------------------------------------
#	StackPosition luu lai vi tri( toa do) cac diem cua duong tron
#	Luu lai cac gia tri tuong ung cua j khi i chay tu 0 -> R
#-------------------------------------------------------------------------------------------------------------------
 	
startDrawCircle:				
	
	addPosition($ra, $t0, $t3, $t5)
	li	$t0, 0					# Bien chay i = 0 
	la	$t5, CIRCLE_DATA 
	
loop_startDrawCircle:

	slt	$v0, $t0, $s2				# Neu i > R -> end_startDrawCicrle
	beqz	$v0, end_startDrawCircle
	mul	$t3, $t0, $t0				# 
	sub 	$t3, $s6, $t3				# $t3 = R^2 - i^2
	move 	$v0, $t3
	jal 	sqrt
	sw 	$a0, 0($t5)				# j = sqrt(R^2 - i^2)
	 
	addi 	$t0, $t0, 1
	add 	$t5, $t5, 4
	j loop_startDrawCircle
	
end_startDrawCircle:

	getPosition($ra, $t0, $t3, $t5)
	jr 	$ra
	
sqrt: 
	mtc1 	$v0, $f0
	cvt.s.w $f0, $f0
	sqrt.s 	$f0, $f0
	cvt.w.s $f0, $f0
	mfc1 	$a0, $f0
	jr 	$ra

#-------------------------------------------------------------------------------------------------------------------
#	Ve diem tren duong tron
# 	Ve dong thoi 2 diem (X0 + i, Y0 +j ) va (Xo + j, Xo + i) doi xung nhau 
#	Tham so $a0 = i ; $a1 = j
#-------------------------------------------------------------------------------------------------------------------

drawCirclePoint:

 	addPoint($t1, $t2, $t4)
 	
	add 	$t1, $s0, $a0 				# xi = x0 + i
	add 	$t4, $s1, $a1				# yi = y0 + j
	mul 	$t2, $t4, $s3				# yi * SCREEN_WIDTH
	add 	$t1, $t1, $t2				# yi * SCREEN_WIDTH + xi (Toa do 1 chieu cua diem anh)
	sll 	$t1, $t1, 2				# Dia chi tuong doi cua diem anh
	sw 	$s5, SCREEN($t1)			# Ve diem anh
	add 	$t1, $s0, $a1 				# xi = x0 + j
	add 	$t4, $s1, $a0				# yi = y0 + i
	mul 	$t2, $t4, $s3				# yi * SCREEN_WIDTH
	add 	$t1, $t1, $t2				# yi * SCREEN_WIDTH + yi (Toa do 1 chieu cua diem anh)
	sll 	$t1, $t1, 2				# Dia chi tuong doi cua diem anh
	sw 	$s5, SCREEN($t1)			# Ve diem anh
	
	getPoint($t1, $t2, $t4)
	jr 	$ra
 
#-------------------------------------------------------------------------------------------------------------------
#	Ve duong tron
#-------------------------------------------------------------------------------------------------------------------
	
 drawCircle:						#draw vong tron voi mau

	addPosition($ra, $t0, $t1, $t3)
 	li 	$t0, 0					# Bien chay i = 0
 	
 loop_drawCircle:
 
  	slt 	$v0, $t0, $s2
 	beqz 	$v0,  end_drawCircle
	
	sll 	$t1, $t0, 2
	lw 	$t3, CIRCLE_DATA($t1) 			# Load j to $t3	 
	
 	move 	$a0, $t0				# $a0 = i
	move 	$a1, $t3				# $a1 = j
	jal 	drawCirclePoint				# Ve 2 diem (x0 + i, y0 + j), (x0 + j, y0 + i)
	sub 	$a1, $zero, $t3
	jal 	drawCirclePoint				# Ve 2 diem (x0 + i, y0 - j), (x0 + j, y0 - i)
	sub 	$a0, $zero, $t0
	jal 	drawCirclePoint				# Ve 2 diem (x0 - i, y0 - j), (x0 - j, y0 - i)
	add 	$a1, $zero, $t3
	jal 	drawCirclePoint				# Ve 2 diem (x0 - i, y0 + j), (x0 - j, y0 + i)
	
	addi 	$t0, $t0, 1
	j 	loop_drawCircle
	
 end_drawCircle:
 
	getPosition($ra, $t0, $t1, $t3)	
 	jr 	$ra

#-------------------------------------------------------------------------------------------------------------------
#	Di chuyen
#-------------------------------------------------------------------------------------------------------------------

moveToLeft:
	li 	$s7, -DELTA_X
 	li 	$t8, 0
	jr 	$ra 	
moveToRight:
	li 	$s7, DELTA_X
 	li 	$t8, 0
	jr 	$ra 	
moveToUp:
	li 	$s7, 0
 	li 	$t8, -DELTA_Y
	jr 	$ra 	
moveToDown:
	li 	$s7, 0
 	li 	$t8, DELTA_Y
	jr 	$ra 			 				 				 		


#-------------------------------------------------------------------
#chuyen sang hinh vuong
#-------------------------------------------------------------------
program1:
readKeyboard1:

 	lw 	$k1, KEY_READY
 	beqz 	$k1, checkPosition1
 	nop
 	lw 	$k0, KEY_CODE
 	beq 	$k0, KEY_A, CASE_A1
 	beq 	$k0, KEY_S, CASE_S1
 	beq 	$k0, KEY_D, CASE_D1
 	beq 	$k0, KEY_W, CASE_W1
 	beq 	$k0, KEY_1, CASE_11
 	beq 	$k0, KEY_2, CASE_21
 	beq 	$k0, KEY_3, CASE_31
 	beq	$k0, KEY_4, CASE_41
 	beq 	$k0, KEY_ENTER, CASE_ENTER
 	j 	checkPosition1
 	
CASE_A1:
 	jal 	moveToLeft
 	j 	checkPosition1
 	
CASE_S1:
 	jal 	moveToDown
 	j 	checkPosition1
 	
CASE_D1:
 	jal 	moveToRight
 	j 	checkPosition1
 	
CASE_W1:
 	jal 	moveToUp
 	j 	checkPosition1
CASE_11:
	li 	$t9, RED
	j	readKeyboard1
CASE_21:
	li 	$t9, YELLOW
	j	readKeyboard1
CASE_31:
	li 	$t9, GREEN
	j	readKeyboard1
CASE_41:
	deleteOldSquaresDrawNewSquares(BACKGROUND)
	setColorAndDrawCirle($t9)
	j 	program			#ve hinh tron
CASE_ENTER1: 
 	j 	endProgram1
 
 		
checkPosition1:		
checkRightExtreme1:

 	add 	$v0, $s0, $s2					# 
 	add 	$v0, $v0,$s7					# 
 	branchIfLessOrEqual($v0, $s3, checkLeftExtreme1)	#
 	jal 	moveToLeft					# Neu x0 + R + DELTA_X > SCREEN_WIDTH -> moveToLeft
 	nop
 	
checkLeftExtreme1:

 	sub 	$v0, $s0, $s2					#
 	add 	$v0, $v0, $s7					#
 	branchIfLessOrEqual($zero, $v0, checkTopExtreme1)	# 	
 	jal 	moveToRight					# Neu x0 - R + DELTA_X < 0 -> moveToRight
 	nop
 	
checkTopExtreme1:

 	sub 	$v0, $s1, $s2					#
 	add 	$v0, $v0, $t8					#
 	branchIfLessOrEqual($zero, $v0, checkBottomExtreme1)	# 
 	jal 	moveToDown					# If y0 - R + DELTA_Y < 0 -> moveToDown
 	nop
 	
checkBottomExtreme1:

 	add 	$v0, $s1, $s2					#
 	add 	$v0, $v0, $t8					#
 	branchIfLessOrEqual($v0, $s4, draw1)			#
 	jal 	moveToUp					# Neu y0 + R + DELTA_Y > SCREEN_HEIGHT -> moveToUp
 	nop
 	
#-------------------------------------------------------------------------------------------------------------------
#	Xoa duong tron cu va ve duong tron moi
#-------------------------------------------------------------------------------------------------------------------

draw1: 	
 	deleteOldSquaresDrawNewSquares(BACKGROUND) 	# Ve hinh vuong trung mau nen
 	add 	$s0, $s0, $s7				# 
 	add 	$s1, $s1, $t8				# Cap nhat toa do moi cua hinh vuong
 	
 	setColorAndDrawSquares($t9)			# Ve hinh vuong moi
 	
 	li 	$a0, DELAY_TIME
 	li 	$v0, 32
 	syscall						# Delay chuong trinh 1 khoang thoi gian
 	
 	j 	program1
 	
endProgram1:

	deleteOldSquaresDrawNewSquares(BACKGROUND)
 	li 	$v0, 10
 	syscall
	
#-------------------------------------------------------------------------------------------------------------------
#	Ve diem tren hinh vuong
# 	Ve dong thoi 2 diem doi xung nhau qua tam
#	Tham so $a0 = i
#-------------------------------------------------------------------------------------------------------------------

drawSquaresPoint:					#ve 2 canh tren duoi

 	addPoint($t1, $t2, $t4)
 	
 	addi 	$t4, $s1, 20				#ve canh tren
	add 	$t1, $s0, $a0 				# xi = x0 + i
	mul 	$t2, $t4, $s3				# yi * SCREEN_WIDTH
	add 	$t1, $t1, $t2				# yi * SCREEN_WIDTH + xi (Toa do 1 chieu cua diem anh)
	sll 	$t1, $t1, 2				# Dia chi tuong doi cua diem anh
	sw 	$s5, SCREEN($t1)			# Ve diem anh voi mau
	add 	$t1, $s0, $a0				# xi = x0 + i
	sub 	$t4, $s1, 20				#ve canh duoi
	mul 	$t2, $t4, $s3				# yi * SCREEN_WIDTH
	add 	$t1, $t1, $t2				# yi * SCREEN_WIDTH + xi (Toa do 1 chieu cua diem anh)
	sll 	$t1, $t1, 2				# Dia chi tuong doi cua diem anh
	sw 	$s5, SCREEN($t1)			# Ve diem anh voi mau
	
	getPoint($t1, $t2, $t4)
	jr 	$ra
 
 drawSquaresPoint1:					#ve 2 canh ben

 	addPoint($t1, $t2, $t4)
 	
 	addi 	$t1, $s0, 20
	add 	$t4, $s1, $a0 				# yi = y0 + i
	mul 	$t2, $t4, $s3				# yi * SCREEN_WIDTH
	add 	$t1, $t1, $t2				# yi * SCREEN_WIDTH + xi (Toa do 1 chieu cua diem anh)
	sll 	$t1, $t1, 2				# Dia chi tuong doi cua diem anh
	sw 	$s5, SCREEN($t1)			# Ve diem anh voi mau
	add 	$t4, $s1, $a0				# yi = y0 + i
	sub 	$t1, $s0, 20
	mul 	$t2, $t4, $s3				# yi * SCREEN_WIDTH
	add 	$t1, $t1, $t2				# yi * SCREEN_WIDTH + xi (Toa do 1 chieu cua diem anh)
	sll 	$t1, $t1, 2				# Dia chi tuong doi cua diem anh
	sw 	$s5, SCREEN($t1)			# Ve diem anh voi mau
	
	getPoint($t1, $t2, $t4)
	jr 	$ra
	
#-------------------------------------------------------------------------------------------------------------------
#	Ve hinh vuong
#-------------------------------------------------------------------------------------------------------------------
	
 drawSquares:						#draw hinh vuong voi mau

	addPosition($ra, $t0, $t1, $t3)
 	li 	$t0, 0					# Bien chay i = 0
 	
 loop_drawSquares:
 
  	slt 	$v0, $t0, $s2				#if i > R, end
 	beqz 	$v0,  end_drawSquares	
	sll 	$t1, $t0, 2	
 	move 	$a0, $t0				# $a0 = i
	jal 	drawSquaresPoint			# Ve 2 diem 
	sub 	$a0, $zero, $t0
	jal 	drawSquaresPoint			# Ve 2 diem 
	jal 	drawSquaresPoint1			# Ve 2 diem 
	add 	$a0, $zero, $t0
	jal 	drawSquaresPoint1			# Ve 2 diem
	 
	addi 	$t0, $t0, 1
	j 	loop_drawSquares
	
 end_drawSquares:
 
	getPosition($ra, $t0, $t1, $t3)	
 	jr 	$ra

