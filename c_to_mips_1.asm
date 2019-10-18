# int i, N;
# i = N*N + 3*N;

li $t0, 10 # N
li $t3, 3

mult $t0, $t0
mflo $t1

mult $t0, $t3
mflo $t2

add $s1, $t1, $t2
