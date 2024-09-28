	.eqv	print_int, 1
	.eqv	print_string, 4
	.eqv	read_string, 8
	.eqv	sys_exit, 10
	.data
prompt:	.asciz	"Enter string:\n"
buf:	.space	100
buf2:	.space	100
	.text
main:
	li	a7, print_string
	la	a0, prompt
	ecall
	li	a7, read_string
	la	a0, buf
	li	a1, 100
	ecall
	la	t0, buf
	la	t1, buf2
	li	t2, 'A'
	li	t3, 'Z'
	li	t5, 32
	li	t6, 0 # licznik
	li	s1, 10
loop:
	lb	t4, (t0)
	blt	t4, t5, endloop1
	beq	t4, t5, space
	blt	t4, t2, skip
	bgt	t4, t3, skip
	addi	t6, t6, 1
skip:
	addi	t0, t0, 1
	j	loop
space:
	sb	t6, (t1)
	addi	t1, t1, 1
	li	t6, 0
	j	skip
endloop1:
	sb	t6, (t1)
	la	t1, buf2
	la	t0, buf
loop2:
	lb	t4, (t0)
	lb	s0, (t1)
	rem	s0, s0, s1
	addi	s0, s0, 48
	blt	t4, t5, endloop2
	beq	t4, t5, space2
	sb	s0, (t0)
skip2:
	addi	t0, t0, 1
	j	loop2
space2:
	addi	t1, t1, 1
	j	skip2
endloop2:
	la	a0, buf
end:
	li	a7, print_string
	ecall
	li	a7, sys_exit
	ecall
