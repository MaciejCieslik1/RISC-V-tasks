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
	li	t2, '['
	li	t3, ']'
	li	t5, 0 # liczba lewych nawiasow
	li	t6, 0 # liczba prawych nawiasow
	li	s0, 1 # stale 1
	li	s1, 0 # licznik
loop:
	lb	t4, (t0)
	beqz	t4, endloop
	beq	t4, t2, l_plus
	beq	t4, t3, r
check:
	bgt	t5, zero, check_r
	j	plus
l_plus:
	addi	t5, t5, 1
	beq	t5, s0, plus
	j	check
check_r:
	bgt	t6, zero, plus
	addi	t0, t0, 1
	j	loop
r:
	blt	t6, t5, r_plus
	j	check
r_plus:
	addi	t6, t6, 1
	j	check
plus:
	addi	s1, s1, 1
	addi	t0, t0, 1
	j	loop
endloop:
	li	a0, 0
	addi	a0, s1, -1

	ret
end:
	li	a7, print_int
	ecall
	li	a7, sys_exit
	ecall
