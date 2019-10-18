# if(i==N){
#     A[2] = 37;
# }

li $t0 15 # N
li $s1 15 # i
li $t1 37 # Element of A
A : .data 32
la $a0, A
L1 : sw $t1, 8($a0)

beq $t0, $s1, L1

# if (N % 2 == 0) N++;

li $t0, 12 # N
li $t1, 2 # for %2

div $t0, $t1
mfhi $t2

beq $t2, $zero, L1 

L1 : addi $t0, $t0, 1 
