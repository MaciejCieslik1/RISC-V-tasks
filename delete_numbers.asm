	.eqv	print_string, 4
	.eqv	read_string, 8
	.eqv	sys_exit, 10
	.data
prompt:	.asciz	"Enter string:\n"
buf:	.space	100
buf2:	.space	100
	.text
	.globl	main
main:
	li	a7, print_string
	la 	a0, prompt
	ecall
	li	a7, read_string
	la	a0, buf
	li	a1, 100
	ecall
	la	t0, buf
	la	t1, buf2
	li	t2, 48
	li	t3, 57
loop:
	lb	t4, (t0)
	blt	t4, t2, copy
	bgt     t4, t3, copy
	j	plus
copy:
	sb	t4, (t1)
	addi	t1, t1, 1
plus:
	beqz	t4, end
	addi	t0, t0, 1
	j	loop
end:
	li	a7, print_string
	la	a0, buf2
	ecall
	li	a7, sys_exit
	ecall
	
	