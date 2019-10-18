# int i, j, temp;
# for (i = (array_size - 1); i > 0; i--) {
# 	for (j = 1; j <= i; j++) {
# 		if (numbers[j-1] > numbers[j]) {
# 			temp = numbers[j-1];
# 			numbers[j-1] = numbers[j];
# 			numbers[j] = temp;
# 		}
# 	}
# }

	.data

numbers: .word -4 5 6 -7 8 9 -10 2 1 3	# array declaration
space: .ascii " "

	.text

la $a0, numbers	# base adress of numbers array
li $t0, 0			# variable for length of the array
li $t3, 1			# j variable
li $t5, 1			# variable for <

lenOfArray:
	lw $t1, 0($a0)				# read numbers[i]
	beq $t1, $zero, purgatory	# if numbers[i] == null go to purgatory
	addi $a0, $a0, 4			# increasing offset of numbers array
	addi $t0, $t0, 1				# length_of_array++
	j	lenOfArray			# go top of the loop

purgatory:
	la $a0, numbers		# reseting base adress of numbers array
	addi $t0, $t0, -1		# lengthOfArray = lengthOfArray - 1
	add $t2, $zero, $t0		# i variable, i = lengthOfArray 
	j 	innerForLoop		# go to innerForLoop

innerForLoop:
	slt $t8, $t2, $t3
	beq $t8, $t5, outerForLoop
	#beq $t3, $t2, outerForLoop					# if j == i go to outerForLoop
	
		lw $t6, 0($a0)							# reading numbers[j-1]
		lw $t7, 4($a0)							# reading numbers[j]
		slt $t8, $t7, $t6							# if numbers[j] < numbers[j-1], t8 = 1
		beq $t8, $t5, innerForLoopInstructions		# if t8 != 1 go to InnerFoorLoopInstructions

	addi $a0, $a0, 4		# increasing offset of numbers array
	addi $t3, $t3, 1			# j++
	j	innerForLoop		# go top of the loop

innerForLoopInstructions:
	add $t4, $zero, $t6		# temp = numbers[j-1]
	add $t6, $zero, $t7		# numbers[j-1] = numbers[j]
	add $t7, $zero, $t4		# numbers[j] = temp

	sw $t6, 0($a0)			# writing numbers[j]
	sw $t7, 4($a0)			# writing numbers[j-1]

	addi $a0, $a0, 4		# increasing offset of numbers array
	addi $t3, $t3, 1			# j++
	j	innerForLoop		# go to innerForLoop

outerForLoop:
	addi $t2, $t2, -1			# i--
	beq $t2, $zero, purgatory2	# if i < 0, go purgatory2
	
		addi $t3, $zero, 1		# j = 1
		la $a0, numbers		# reseting base adress of numbers
		

	j 	innerForLoop			# go to innerForLoop

purgatory2:
	la $a1, numbers			# reseting base adress of numbers
	la $a2, space				# base adress of space string
	addi $t0, $t0, 1				# lenOfArray += 1
	li $t1, 1					# variable for controlling condition in print
	j	print					# go to print

print:
	beq $t1, $t0, EXIT			# if t1 == lenOfArray, go EXIT
		
		lw $a0, 0($a1)			# reading numbers[i]
		li $v0, 1				# read Integer
		syscall				# syscall

		la $a0, space
		li $v0, 4
		syscall
		
	addi $a1, $a1, 4			# increasing offset of numbers array
	addi $t1, $t1, 1				# i++
	j	print					# go top of the funcion

EXIT:
