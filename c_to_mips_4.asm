# int A[10], B[10];
# for (i=1; i < 10; i++) {
# 	A[i] = A[i-1] + B[i] ;
# }

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
