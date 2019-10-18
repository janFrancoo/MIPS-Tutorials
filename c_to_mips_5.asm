# i = j + k - l + A[6]

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
