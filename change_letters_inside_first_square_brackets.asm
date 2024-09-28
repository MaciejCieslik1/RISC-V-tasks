	.eqv	print_int, 1
	.eqv	print_string, 4
	.eqv	read_string, 8
	.eqv	sys_exit, 10
	.data
prompt:	.asciz	"Enter string:\n"
buf:	.space	100
	.text
main:
	li	a7, print_string
	la	a0, prompt
	ecall
	li	a7, read_string
	la	a0, buf
	li	a1, 100
	ecall
	jal	remove
	j	end
remove:
	la	t0, buf
	li	t1, 32
	li	t2, '['
	li	t3, ']'
	li	t5, 0 # liczba lewych nawiasow
	li	t6, 0 # liczba prawych nawiasow
	li	s0, 1 # stale 1
	li	s1, 0 # licznik
	li	s2, '*'
loop:
	lb	t4, (t0)
	blt	t4, t1, end_loop
	beq	t4, t2, left_bracket
	beq	t4, t3, rigth_bracket
check:
	bgt	t6, zero, skip
	beq	t5, zero, skip
	j	write
left_bracket:
	addi	t5, t5, 1
	beq	t5, s0, skip
	j	check
rigth_bracket:
	bge	t6, t5, check
	addi	t6, t6, 1
skip:
	addi 	t0, t0, 1
	addi	s1, s1, 1
	j	loop
write:
	sb	s2, (t0)
	j	skip
end_loop:
	la	a0, buf
	ret
end:
	li	a7, print_string
	ecall
	mv	a0, s1
	li	a7, print_int
	ecall
	li	a7, sys_exit
	ecall
