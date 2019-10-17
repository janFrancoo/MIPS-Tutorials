#	A[i] = A[i/2] + 1;
#	A[i+1] = -1;
#	i stored in $s1, A[0] stored in $a0

	.data

A : .word 1 2 3 4 5 6 7 8 9			# defining array 'A'

	.text

la $a0, A					# base adress of A
li  $s1, 2					# variable i
li  $t0,  2 					# temp value for multiplication
li  $t1,  4					# temp value for multiplication
li  $t7, -1					# value -1 for A[i+1] = -1

mult $s1, $t0					# multiplication process : i * 2 |||  (i / 2) * 4 = i * 2 
mflo	$t2					# result of the multiplication

mult $s1, $t1					# multiplication process : i * 4
mflo $t3					# result of the multiplication

add $a0, $a0, $t3				# offset of A[i]
add $t4,  $a0, $t2				# offset of A[i/2]

lw $t5, 0($t4)					# reading A[i/2]
addi $t5, $t5, 1				# addition process : A[i/2] + 1
sw $t5, 0($a0)					# writing result to A[i]

lw $t6, 0($a0)					# controlling A[i]

la $a0, A					# base adress of A
sw $t7, 4($a0)					# writing -1 value to A[i+1]

lw $t8, 4($a0)					# controlling A[i+1]


# Q2) 	int A[10], B[10];
#	for (i=1; i < 10; i++) {
#		A[i] = A[i-1] + B[i] ;
#	}

	.data

A : .word 2 4 6 8 10 12 14 16 18 20	# defining array 'A'
B : .word 1 2 3 4 5   6   7   8   9   10	# defining array 'B'

	.text
	
la $a0, A # base adress of A
la $a1, B # base adress of B	

li $t0 1  # i = 1
li $t1 10 # i < 10

loop:
	beq $t0, $t1, EXIT # if i == 10 go to EXIT
		
		lw $s1, 0($a0)		# reading A[i-1]
		lw $s2, 4($a1)		# reading B[i]
		
		add $t2, $s1, $s2 	# t2 = A[i-1] + B[i]
		sw $t2, 4($a0)		# writing A[i]
		
		addi $a0, $a0, 4	# +4 bit increasing offset of A
		addi $a1, $a1, 4	# +4 bit increasing offset of B
					
	addi $t0, $t0, 1 # i++
	j    loop 	 # go to loop
EXIT: 
