########################################################################################
## i = j + k - l + A[6]

	.data
	
A: 1 2 3 4 5 6 7 8				# defining array A

	.text

li $s1, 1	# variable j
li $s2, 2	# variable k
li $s3, 3	# variable l
la $s4, A	# base adress of A

add $t0, $s1, $s2	# j + k
sub $t0, $t0, $s3		# j + k - l

addi $s4, $s4, 24		# offset of A[6]
lw $s6, 0($s4)			# reading A[6]

add $s0, $t0, $s6

########################################################################################
## i = j + k + l  – A[B[5]]

	.data
	
A: 2 4 6 8 10 12 14 16		# defining array A
B: 1 2 3 4 5 6 7 8				# defining array B

	.text

li $s1, 1	# variable j
li $s2, 2	# variable k
li $s3, 3	# variable l
li $t9, 4	# variable for multiplication
la $s4, A	# base adress of A
la $s5, B	# base adress of B

add $t0, $s1, $s2	# j + k
add $t0, $t0, $s3		# j + k + l

addi $s5, $s5, 20		# offset of B[5]
lw $s6, 0($s5)			# reading B[5]

mult $s6, $t9			# B[5] * 4
mflo $t1					# result of the multiplication
add $s4, $s4, $t1    # 
lw $s7, 0($s4)			# reading A[B[5]]

sub $t8, $t0, $s7
	

################################################################################
# int A[100], B[100];
# for (j = 1; j < 100; j++){
# 		for (i = j; i < 100; i++) {
# 			B[i] = B[i-1] + A[j] ;
#		}
# }


	.data
	
A: 1 2 3 4 5 6 7 8 9 10		# defining array A
B: 1 2 3 4 5 6 7 8 9 10		# defining array B

	.text
	
li $t0, 0			# variable i
li $t1, 10			# variable for i = 10, j = 10
li $t2, 1			# variable j
li $k0, 4			# variable for multiplicaiton
la $a0, A			# base adress of A
la $a1, B			# base adress of B

loop:
	beq $t2, $t1, EXIT	# for j = 1 ; j < 10 -- if j == 10 go to EXIT
	add $t0, $zero, $t2		# i = j
	j	loop2
		
loop2:
	beq $t0, $t1, tempProcess		# for i = j; i < 10;
	
	la $a0, A
	la $a1, B
	
	mult $t2, $k0			# j * 4
	mflo $t3					# result of the multiplication
	add $a0, $a0, $t3	# offset of A[j]
	lw $t5, 0($a0)			# reading A[j]
	
	addi $t4, $t0, -1		# i - 1
	mult $t4, $k0			# 4 * (i - 1)
	mflo $t3					# result of the multiplication
	add $a1, $a1, $t3	# offset of B[i-1]
	lw $t6, 0($a1)			# reading B[i-1]
	
	add $t7, $t5, $t6		# A[j] + B[i-1]
	
	mult $t0, $k0			# i * 4
	mflo $t3					# result of the multiplication
	add $a1, $a1, $t3	# offset of B[i]
	sw $t7, 0($a1)			# writing the result to B[i]
	
	addi $t0, $t0, 1		# j++
	j loop2
	
tempProcess:
	addi $t2, $t2, 1
	j loop
	
EXIT:
	
################################################################################
# int A[100], B[100];
# for (j = 1; j < 100; j++){
# 		for (i = j; i < 100; i++) {
# 			B[i] = B[i-1] + A[j] ;
# 		}
# }

	.data
	
A: 1 2 3 4 5 6 7 8 9 10		# defining array A
B: 1 2 3 4 5 6 7 8 9 10		# defining array B

	.text
	
li $t0, 1			# variable i
li $t1, 10			# variable for i = 10, j = 10
li $t2, 0			# variable j
li $k0, 4			# variable for multiplicaiton
la $a0, A			# base adress of A
la $a1, B			# base adress of B

loop:
	beq $t0, $t1, EXIT	# for i = 1 ; i < 10 -- if i == 10 go to EXIT
	
	add $t2, $t2, $t0						# j = i
	
	mult $t2, $k0			# j * 4
	mflo $t3					# result of the multiplication
	add $a0, $a0, $t3	# offset of A[j]
	lw $t5, 0($a0)			# reading A[j]
	
	j	loop2
		
loop2:
	beq $t2, $t1, tempProcess		# for j = i ; j <10 -- if j == 10 go to loop
	
	addi $t4, $t0, -1		# i - 1
	mult $t4, $k0			# 4 * (i - 1)
	mflo $t3					# result of the multiplication
	add $a1, $a1, $t3	# offset of B[i-1]
	lw $t6, 0($a1)			# reading B[i-1]
	
	add $t7, $t5, $t6		# A[j] + B[i-1]
	
	mult $t0, $k0			# i * 4
	mflo $t3					# result of the multiplication
	add $a1, $a1, $t3	# offset of B[i]
	sw $t7, 0($a1)			# writing the result to B[i]
	
	addi $t2, $t2, 1		# j++
	j loop2
	
tempProcess:
	addi $t2, $zero, 1
	addi $t0, $t0, 1
	j loop
	
EXIT:
	
