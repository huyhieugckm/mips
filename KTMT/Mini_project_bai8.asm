.data
NAME_array: .space 40
name: .space 2000
MARK_array: .space 40
Menu: .asciiz "1. Run program.\n2. Exit.\nYour choose: "
WrongChoose: .asciiz "Your choose is wrong. Please try again\n"
NumberOfStudents: .asciiz "Enter number of students: "
NameOfStudents: .asciiz "Enter Name of Student: "
MarkOfStudents: .asciiz "Enter Mark of Student: "
new_line: .asciiz "\n"
print_mark: "Mark: "
after_sort: .asciiz "After sorting: \n"
.text
menu:	
	li $v0, 4
	la $a0, Menu
	syscall
choose: 
	li $v0, 5
	syscall
	move $s0, $v0
	beq $s0, 1, main
	beq $s0, 2, end
	li $v0, 4
	la $a0, WrongChoose
	syscall
	j menu
############################
main: 
	li $v0, 4
	la $a0, NumberOfStudents
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	blez $s0, main
	add $t3, $zero, $zero		#index oj mark array = 0
	add $t0, $zero, $zero		#index of name array = 0
	add $t1, $zero, $zero		#counter loop = 0 
	la $s2, name			#load address of string to $s2
############################
while:
	bge $t1, $s0, PrintNameBS 	#check loop, print name before sorting
	li $v0, 4
	la $a0, NameOfStudents
	syscall
	move $a0, $s2			#place to store string
	li $a1, 20
	li $v0, 8
	syscall
	sw $a0, NAME_array($t0)
checkMark:
	li $v0, 4
	la $a0, MarkOfStudents
	syscall
	li $v0, 5
	syscall	
	blt $v0, 0, checkMark		#if mark less than 0 or greater than 10, jump checkMark
	bge $v0, 11, checkMark		
	sw $v0, MARK_array($t3)	#store mark in arrays
	addi $t3, $t3, 4		#increase address of mark_array
	addi $t0, $t0, 4
	addi $s2, $s2, 20		#next string area
	addi $t1, $t1, 1		#increase counter by 1
	j while
##################
PrintNameBS:				#print name before sort
	add $t3, $zero, $zero
	add $t0, $zero, $zero		#index of name array
	add $t1, $zero, $zero		#counter = 1
while_loop_1:
	bge $t1, $s0, compareMark
	lw $t2, NAME_array($t0)
	li $v0, 4
	move $a0, $t2
	syscall
	li $v0, 4
	la $a0, print_mark
	syscall
	li $v0, 1
	lw $s1, MARK_array($t3)
	move $a0, $s1 
	syscall
	li $v0, 4
	la $a0, new_line
	syscall
	addi $t3, $t3, 4
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	j while_loop_1
#####################
compareMark:
loop: 	
	move $t1, $s0			#get total of elements
	subi $a1, $t1, 1
	blez $a1, done
	la $a0, MARK_array
	la $a2, NAME_array
	li $t2, 0			# clear the "did swap" flag
	jal pass_loop			# do a single sort 
	beqz $t2, done
	subi $t1, $t1, 1
	b loop
done: 	j PrintNameAS
pass_loop: 
	lw $s1, ($a0)
	lw $s2, 4($a0)
	lw $s3, ($a2)
	lw $s4, 4($a2)
	bgt $s1, $s2, swap 
next: 
	addi $a2, $a2, 4
	addi $a0, $a0, 4
	subi $a1, $a1, 1
	bgtz $a1, pass_loop
	jr $ra
swap: 
	sw $s1, 4($a0) 
	sw $s2, 0($a0)
	sw $s3, 4($a2)
	sw $s4, ($a2)
	li $t2, 1
	j next
######################################
PrintNameAS: 				#print name after sort
	li $v0, 4
	la $a0, after_sort
	syscall
	add $t3, $zero, $zero
	add $t0, $zero, $zero
	add $t1, $zero, $zero
while_loop_2:
	bge $t1, $s0, menu
	lw $t2, NAME_array($t0)
	li $v0, 4
	move $a0, $t2
	syscall
	li $v0, 4
	la $a0, print_mark
	syscall
	li $v0, 1
	lw $s1, MARK_array($t3)
	move $a0, $s1 
	syscall
	li $v0, 4
	la $a0, new_line
	syscall
	addi $t3, $t3, 4
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	j while_loop_2
end: 
	li $v0, 10
	syscall
	
