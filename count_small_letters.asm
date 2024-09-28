	.eqv	print_int, 1
	.eqv	print_string, 4
	.eqv	read_string, 8
	.eqv	sys_exit, 10
	.data
prompt:	.asciz	"Enter string:\n"
buf:	.space	100
	.globl	main
	.globl	remove
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
	la	t1, buf
	li	t2, 'a'
	li	t3, 'z'
	jal	remove
	j	end
remove:
	lb 	t4, (t0)
	beqz	t4, count
	blt	t4, t2, skip
	bgt	t4, t3, skip
	sb	t4, (t1)
	addi	t1, t1, 1
skip:
	addi	t0, t0, 1
	j	remove
count:	
	la	t0, buf
	sub	a0, t1, t0
	ret
end:
	li	a7, print_int
	ecall
	li	a7, sys_exit
	ecall
