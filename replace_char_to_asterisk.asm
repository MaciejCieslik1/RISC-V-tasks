	.data
prompt: .asciz "Enter string:\n"
buf:	.space 100

	.text
	.globl main
main:
	li a7, 4
	la a0, prompt
	ecall

	li a7, 8
	la a0, buf
	li a1, 100
	ecall
	
	li t0, '['
	li t1, ']'
	li t2, 0 # len counter
	li t5, -1 # switch
	li t6, '*'
	li s0, '\n'
	
	la t3, buf
	lb t4, (t3)
	beqz t4, end
loop:
	addi t2, t2, 1
	beqz t5, next
	sb t6, (t3)
next:
	beq t4, t1, switch
	
	addi t3, t3, 1
	lb t4, (t3)
	
	beq t4, t0, switch2
	
	bne t4, s0, loop
	b end
switch:
	addi t5, t5, 1
	addi t3, t3, 1
	lb t4, (t3)
	bne t4, s0, loop
	b end
switch2:
	addi t5, t5, 1
	bne t4, s0, loop
end:	
	
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 1
	addi a0, zero, 0
	addi a0, t2, 0
	ecall
	
	li a7, 10
	ecall