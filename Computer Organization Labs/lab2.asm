# Q1) Here, you can assume N is stored in register $t0 and the variable i is stored in $s1. Make the
# following calculation by giving a sample value to N and see the result in $s1 [30pts]
#int i, N;
# i = N*N + 3*N;

li $t0, 10 # N
li $t3, 3

mult $t0, $t0
mflo $t1

mult $t0, $t3
mflo $t2

add $s1, $t1, $t2

# Q2) Here, you can assume N is stored in register $t0 and the variable i is stored in $s1, and base address
# of array A is $a0. Make the following calculation by giving a sample value to N and see the result in $s1
#if (i==N) {
# A[2] = 37;
#}

li $t0 15 # N
li $s1 15 # i
li $t1 37 # Element of A
A : .data 32
la $a0, A
L1 : sw $t1, 8($a0)

beq $t0, $s1, L1

# Q3) Here, you can assume N is stored in register $t0.
# if ( N%2 == 0 ) N++;

li $t0, 12 # N
li $t1, 2 # for %2

div $t0, $t1
mfhi $t2

beq $t2, $zero, L1 

L1 : addi $t0, $t0, 1 
