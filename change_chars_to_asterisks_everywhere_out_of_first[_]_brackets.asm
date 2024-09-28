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
	jal replace
	j	end
replace:
	la	t0, buf
	li	t1, 32
	li	t2, '['
	li	t3, ']'
	li	t5, 0 # amount of left brackets
	li	t6, 0 # amount of rigth brackets
	li	s0, '*'
	li	s1, 1
loop:
	lb	t4, (t0)
	blt	t4, t1, end_loop
	beq	t4, t2, left_bracket
	beq	t4, t3, rigth_bracket
check:
	beq	t5, zero, write
	bgt	t6, zero, write
	j	skip
left_bracket:
	addi	t5, t5, 1
	j	check
rigth_bracket:
	bge	t6, t5, check
	beq	t6, s1, write
	addi	t6, t6, 1
	
skip:
	addi 	t0, t0, 1
	j	loop
write:
	sb	s0, (t0)
	j	skip

end_loop:
	la	a0, buf
	ret
end:
	li	a7, print_string
	ecall
	li	a7, sys_exit
	ecall
	
