.global __start
.text
__start:

addi x2,x0,1500
addi x3,x0,2047
mul x1,x2,x3
add x4,x2,x3
rem x7,x4,x1
mulh x8,x7,x1
bne x3,x2, 8
EBREAK