	.eqv	print_string, 4
	.eqv	print_int, 1
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
	la	t0, buf		# adres bufora(zmienny w petli)
	la	t1, buf2	# adres bufora 2
	li	s0, 0		# dlugosc stringa
	li	t2, 0		# znak null
	li	t3, 10		# znak nowej linii	
	la	t5, buf		# kopia adresu poczakowego bufora wyrazu
size:	
	lb 	t4, (t0)
	beq 	t4, t3, count
	addi 	t0, t0, 1
	j	size
count:
	sub 	s0, t0, t5
	add	t1, t1, s0
	sb	t2, (t1)
	addi	t1, t1, -1
	la	t0, buf
loop:
	lb	t4, (t0)
	beq	t4, t2, end
	sb	t4, (t1)
	addi	t1, t1, -1
	addi	t0, t0, 1
	j	loop
end:
	la	a0, buf2
	li	a7, print_string
	ecall
	li	a7, sys_exit
	ecall