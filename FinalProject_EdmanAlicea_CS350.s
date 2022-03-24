#Name: Edman G. Alicea
#Class: CS 350, Final Project
#Date: 11/10/21		


#USER MANUAL DOCUMENT:
#This programs is a calculator application.
#A input of zero will exit the program only after the "Which operations would..." is displayed
#It ask the user for a specific numerical input from 0-8 to choose a desired action
#It then branches to that specific location on the program to perform the desired operations
#the program ask the user for numerical input then does the calculations
#the program only accepts up to two numerical inputs per calculation
#it will at most accept only 1 depending on calculation
#the program then outputs the data in integer form
#the program then loops and is ready for calculation selection (or program exit) again
	.data
	



msg1: .asciiz "\n\nWhich Operation do you want to perform? (Enter number associated with action):\n 0 Exit program \n 1 Addition \n 2 Subtraction \n 3 Multiplication \n 4 Division \n 5 Modulo \n 6 Factorial \n 7 Sum(n,m) n < m \n 8 Fibonacci Sequence \nEnter Desired Operation: "

foperand: .asciiz "\nFirst Operand: "

soperand: .asciiz "\nSecond Operand: "

answer: .asciiz "\nAnswer: "

space: .asciiz "\n"

sumwarning: .asciiz "\n WARNING (First operand < Second Operand) Input must be like this or else program will reset to an initial state"

	.globl main
	.text

main:

	li $t0, 0	#initialize variable to 0 so that the program doesnt have to			
	li $t1, 0	#worry about previous runs affecting logic
	li $t2, 0
	li $t3, 0
	li $t4, 0
	li $t5, 0

	li $v0, 4	#print msg1
	la $a0, msg1
	syscall



	li $v0, 5	#ask for user input and store in $t0
	syscall
	add $t0, $v0, $zero
	

	beq $t0, 0, exit		#branch to specific location depending on $t0 input
	beq $t0, 1, add1
	beq $t0, 2, sub2
	beq $t0, 3, mult3
	beq $t0, 4, div4
	beq $t0, 5, mod5
	beq $t0, 6, fac6
	beq $t0, 7, sum7
	beq $t0, 8, fib8
	
	j main			#loop main

	
add1:

	
	li $v0, 4		#print foperand text
	la $a0, foperand
	syscall

	li $v0, 5
	syscall 
	add $t1, $v0, $zero	#store input into $t1

	li $v0, 4		#print soperand text
	la $a0, soperand
	syscall

	
	li $v0, 5
	syscall 
	add $t2, $v0, $zero	#store input into $t2


	add $t0, $t2, $t1	# $t0 = $t2 + $t1

	
	li $v0, 4		#print answer msg
	la $a0, answer
	syscall


	li $v0, 1		#print answer integer
	move $a0, $t0
	syscall

	j main			#jump to main

sub2:

	li $v0, 4		#print foperand text	
	la $a0, foperand
	syscall

	li $v0, 5
	syscall 
	add $t1, $v0, $zero  	#store input into $t1

	li $v0, 4		#print soperand text
	la $a0, soperand
	syscall

	
	li $v0, 5
	syscall 
	add $t2, $v0, $zero	#store input into $t2


	sub $t0, $t1, $t2	# $t0 = $t1 - $t2


	li $v0, 4		#print answer msg
	la $a0, answer
	syscall


	li $v0, 1		#print answer integer
	move $a0, $t0
	syscall
	
	j main			#jump to main

mult3:

	li $v0, 4		#print foperand text 
	la $a0, foperand
	syscall

	li $v0, 5
	syscall 
	add $t1, $v0, $zero	#store input in $t1

	li $v0, 4		#print soperand text
	la $a0, soperand
	syscall

	
	li $v0, 5		
	syscall 
	add $t2, $v0, $zero	#store input in $t2


	mul $t0, $t2, $t1	# $t0 = $t2 * $t1

	li $v0, 4		#print answer message
	la $a0, answer
	syscall

	li $v0, 1		#print answer integer
	move $a0, $t0
	syscall

	j main			#jump to main
div4:

	li $v0, 4		#print foperand text
	la $a0, foperand
	syscall

	li $v0, 5
	syscall 
	add $t1, $v0, $zero	#store input into $t1

	li $v0, 4		#print soperand texxt
	la $a0, soperand
	syscall

	
	li $v0, 5
	syscall 
	add $t2, $v0, $zero	#store input into $t2


	div $t1, $t2	# divide $t1 and $t2 ($t1/$t2) remainder stored in hi and quotient store in lo

	li $v0, 4	#print answer message
	la $a0, answer
	syscall

	li $v0, 1
	mflo $a0		#move quotient stored in lo register to $a0 and print it
	syscall

	j main		#jump to main


mod5:


	li $v0, 4		#print foperand text
	la $a0, foperand
	syscall

	li $v0, 5
	syscall 
	add $t1, $v0, $zero	#store input into $t1

	li $v0, 4		#print soperand text
	la $a0, soperand
	syscall

	
	li $v0, 5
	syscall 
	add $t2, $v0, $zero	#store input in $t2


	div $t1, $t2	# $t1/$t2 remainder stored in hi and quotient store in lo

	li $v0, 4	#print answer msg
	la $a0, answer
	syscall

	li $v0, 1
	mfhi $a0		#move remainder stored in hi register to $a0 and print it
	syscall

	j main		#jump to main


fac6:
	

	

	li $v0, 4	#print foperand text
	la $a0, foperand
	syscall

	li $v0, 5	#store user input into $t1
	syscall 
	add $t1, $v0, $zero



	li $t2, 1 	#  $t1 = user input (eg 5!), $t2 = counter, $t4 = fact		
	li $t4, 1

	jal faclogic	#jump to faclogic and store pc location to $ra

	li $v0, 4	#print answer msg
	la $a0, answer
	syscall

	li $v0, 1	#move answer in $t4 to $a0 and print it
	move $a0, $t4
	syscall

	j main		#jump to main
	

faclogic:

	blt $t1, $t2, jump	#if $t1 < $t2 go to jump
	


	mul $t4, $t4, $t2 	# $t4 = $t4 * $t2 
				# $t2 is counter variable. t4 is sum of factorial up to that point 
	
	#li $v0, 4		#debugging code
	#la $a0, space
	#syscall

	#li $v0, 1		#debugging code
	#move $a0, $t4
	#syscall

	addi $t2, $t2, 1 	# $t2 = $t2 + 1
	
	j faclogic		#loop factlogic



	
jump: 
	jr $ra	#resume program execution in a particular spot





sum7:

	li $v0, 4		#print special warning for sum7
	la $a0, sumwarning
	syscall


	li $v0, 4		#print foperand text
	la $a0, foperand
	syscall

	li $v0, 5
	syscall 
	add $t1, $v0, $zero	#store first input in $t1

	li $v0, 4		#print soperand text
	la $a0, soperand
	syscall

	
	li $v0, 5
	syscall 
	add $t2, $v0, $zero	#store second input in $t2

	bgt $t1, $t2, main	# if ($t1 > $t2) go to main
	
	jal sumlogic	#jump and link sumlogic



	
	li $v0, 4	#print answer msg
	la $a0, answer
	syscall

	li $v0, 1	#print int result stored in $t3
	move $a0, $t3
	syscall


	
	j main
	
sumlogic:


	bgt $t1, $t2, jump	#if $t1 > $t2, go to jump

	add $t3, $t3, $t1	# $t3 = $t3 + $t1 



	addi $t1, $t1, 1		# $t1 = $t1 + 1
	


	j sumlogic		#loop



fib8:


	li $v0, 4	#print foperand text
	la $a0, foperand
	syscall

	li $v0, 5	#store user input into $t5
	syscall 
	add $t5, $v0, $zero

	beq $t5, 0, fibzero	#if $t5 = 0, branch to fibzero
	beq $t5, 1, fibone	#if $t5 = 1, branch to fibone

	li $t1, 0 	# $t1 = 0	
	li $t2, 1	# $t2 = 1
	
	jal fiblogic	#jump to fiblogic and store pc location to $ra

	li $v0, 4	#print answer msg
	la $a0, answer
	syscall

	li $v0, 1	#print integer in $t3
	move $a0, $t3
	syscall

	j main



fibzero:

	li $v0, 4	#print answer text
	la $a0, answer
	syscall

	li $t1, 0	# $t1 = 0 

	li $v0, 1	#print $t1
	move $a0, $t1	
	syscall

	
	j main
fibone:

	li $v0, 4	#print answer text
	la $a0, answer
	syscall

	li $t1, 1	# $t1 = 1 

	li $v0, 1	#print $t1
	move $a0, $t1	
	syscall

	
	j main


fiblogic:

	addi $t4, $t4, 1		# $t4 = $t4 + 1

	beq $t5, $t4, jump	# if ($t5 == $t3), branch to jump
	
	add $t3, $t1, $t2	# $t3 = $t1 + $t2
	add $t1, $t2, $zero	# $t1 = $t2
	add $t2, $t3, $zero	# $t2 = $t3

	
	
	j fiblogic	#loop



	
exit:

	li $v0,10	#exit from program
	syscall




