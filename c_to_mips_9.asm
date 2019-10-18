# int num,i,count,sum=0;
# for(num=1; num<=100; num++){
# 	count = 0;
# 	for(i=2; i<=num/2; i++){
# 		if(num % i == 0){
# 		count++;
# 		break;
# 		}
# 	}
# 	if(count == 0 && num != 1)
# 		sum += num;
# }
# printf("Sum of prime numbers is: %d ",sum);

	.data

Message: .ascii "Sum of prime numbers is: "

	.text

li $t0, 1		# i variable
li $t1, 100		# N variable
li $a1, 0		# sum variable

loop:
	beq $t0, $t1, print	# if i == N go to print
	
		li $t2, 0			# c = 0
		li $t3, 2			# j = 2
		divu $t4, $t0, 2		# i / 2
		addi $t4, $t4, 1		# j <= i / 2
		
	j innerLoop	# go to innerLoop
	
innerLoop:
	beq $t3, $t4, temp	# if j == i/2 go to temp
	bge $t3, $t4, temp	# if j > i/2 go to temp

		div $t0, $t3				# j / i
		mfhi $t6					# remainder of j / i
		beq $t6, $zero, increaseC	# if remainder of j / i == 0 go to increaseC

	addi $t3, $t3, 1 	# j++
	j innerLoop		# go to innerLoop

temp:
	beq $t2, $zero, temp2	# if c == 0 go to temp2
	addi $t0, $t0, 1			# i++
	j loop				# go to loop

temp2:
	bne $t0, 1, increaseSum 		# if i != 1 go to increaseSum
	addi $t0, $t0, 1				# i++
	j loop					# go to loop

increaseSum:
	add $a1, $a1, $t0			# sum += i
	addi $t0, $t0, 1				# i++
	j loop					# go to loop

increaseC:
	addi $t2, $t2, 1				# c++
	addi  $t0, $t0, 1			# i++
	j loop					# go to loop

print:
	la $a0, Message			# load adress of Message
	li $v0, 4					# v0 = 4 for printing string
	syscall					# systemcall

	move $a0, $a1				# move a1 to a0 for printing
	li $v0, 1					# v0 = 1 for printing integer
	syscall					# systemcall
