i = j + k + l  – A[B[5]]

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
