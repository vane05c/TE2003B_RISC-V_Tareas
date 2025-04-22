.data
A: .word 1, 2, 3 # address 0x10000000
   .word 4, 5, 6
   .word 7, 8, 9

B: .word 9, 8, 7 # address 0x10000024
   .word 6, 5, 4
   .word 3, 2, 1

C: .word 0, 0, 0 # address 0x10000048
   .word 0, 0, 0
   .word 0, 0, 0

.text
main:
    li t0, 0 # fila actual (i)
    li s3, 3 # tam
    la s0, A
    la s1, B
    la s4, C

fils:
    bge t0, s3, end
    li t1, 0 # columna actual (j)

cols:
    bge t1, s3, sigFila
    li t2, 0 # idx (k)
    li s2, 0 # acc

prod:
    bge t2, s3, guardar

    mul t3, t0, s3
    add t3, t3, t2
    slli t3, t3, 2
    add t4, s0, t3
    lw t5, 0(t4)

    mul t3, t2, s3
    add t3, t3, t1
    slli t3, t3, 2
    add t4, s1, t3
    lw t6, 0(t4)

    mul t3, t5, t6
    add s2, s2, t3

    addi t2, t2, 1
    j prod

guardar:
    mul t3, t0, s3
    add t3, t3, t1
    slli t3, t3, 2
    add t4, s4, t3
    sw s2, 0(t4)

    mv a0, s2
    li a7, 1
    ecall

    li a0, 32
    li a7, 11
    ecall

    addi t1, t1, 1
    j cols

sigFila:
    li a0, 10
    li a7, 11
    ecall

    addi t0, t0, 1
    j fils

end:
    li a7, 10
    ecall
