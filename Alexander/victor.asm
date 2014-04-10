	.data
datalen:
	.word	0x0010	# 16
data:
	.word	0xffff7e81
	.word	0x00000001
	.word	0x00000002
	.word	0xffff0001
	.word	0x00000000
	.word	0x00000001
	.word	0xffffffff
	.word	0x00000000
	.word	0xe3456687
	.word	0xa001aa88
	.word	0xf0e159ea
	.word	0x9152137b
	.word	0xaab385a1
	.word	0x31093c54
	.word	0x42102f37
	.word	0x00ee655b
lf:
	.word	10
.text
	# t0 = index
	# t1 = address
	# t2 = offset
	# t3 = current value
	# t4 = array lenght
	init:
		li	$t0,	0
		lw 	$t4,	datalen
		li	$t2,	0
		la	$t1,	data
		
		jal sort
		nop
	main:
		add $t3,	$t2,	$t1		# Add offset and address to get the next value
		
		jal printElement
		nop
		
		add	$t2,	$t2, 	4		# Increase the offset by 4 bytes (aka 32 bit)
		
		add	$t0,	$t0,	1		# Increase the current iteration count
		blt	$t0,	$t4,	main	# Make sure we aren't outside of the array 
		nop
		
		li	$v0,	10				# Load the exit code
		syscall
		
printElement:
		lw	$a0,	0($t3)			# Read the word from the address with an offset of 0 (we already added offset)
		li	$v0,	1				# Add the code for print integer
		syscall
		
		lw	$a0,	lf				# Add a newline (linefeed) character
		li	$v0,	11				# Add the code for print character
		syscall
		jr	$ra
		nop
		
sort:
	# Init the counters
	li	$s0,	0
	li	$s1,	0
	
	sloop:
	li	$s2,	0
	li	$s3,	0
	
	mul	$s2,	$s0,	4
	mul	$s3,	$s1,	4
	
	add $s2,	$t1,	$s2
	add $s3,	$t1,	$s3
	
	lw	$s4,	0($s2)
	lw	$s5,	0($s3)
	blt $s4,	$s5,	noswap
	nop
	
	sw	$s5,	0($s2)
	sw	$s4,	0($s3)
	
	noswap:
	add $s1,	$s1,	1
	
	blt $s1,	$t4		sloop
	nop
	
	add $s0,	$s0,	1
	blt	$s0,	$t4,	sloop
	add $s1,	$s0,	$0
	
	jr $ra
	nop