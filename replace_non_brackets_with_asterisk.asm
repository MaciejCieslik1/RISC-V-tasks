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
	jal	replace
	j	end
replace:
	la	t0, buf
	li	t1, '*'
	li	t2, 'a'
	li	t3, 'z'
	li	t5, 0
	j	loop
loop:
	lb	t4, (t0)
	beqz	t4, end_loop
	blt	t4 t2, skip
	bgt	t4, t3, skip
	sb	t1, (t0)
skip:
	addi	t0, t0, 1
	addi	t5, t5, 1
	j	loop
end_loop:
	addi	t5, t5, -1
	la	a0, buf
	ret
end:
	li	a7, print_string
	ecall
	mv	a0, t5
	li	a7, print_int
	ecall
	li	a7, sys_exit
	ecall