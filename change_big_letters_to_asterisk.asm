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
	jal	func
	j	end
func:
	la	t0, buf
	li	t1, 'A'
	li	t2, 'Z'
	li	t3, '*'
loop:
	lb	t4, (t0)
	beqz	t4, end_loop
	blt	t4, t1, skip
	bgt	t4, t2, skip
	sb	t3, (t0)
skip:
	addi	t0, t0, 1
	j	loop
end_loop:
	la	a0, buf
	ret
end:
	li	a7, print_string
	ecall
	li	a7, sys_exit
	ecall