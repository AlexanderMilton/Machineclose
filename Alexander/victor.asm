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
		li	$t0,	0		# Iteration counter
		la	$t1,	data		# Address pointer to data list
		li	$t2,	0		# Offset (4 bytes) used to fetch values from list in address
		# 	$t3 			holds the current value, used for printing. Initiated elsewhere
		lw 	$t4,	datalen		# Length of array
		
		jal 	sort			# Jump to sorting label
		nop				# Avoid additional operation
		
main:
		add 	$t3,	$t2,	$t1	# Add offset and address to get the next value
		
		jal 	printElement		# Print current values (stored in $t3)
		nop				# Avoid additional operation
		
		add	$t2,	$t2, 	4	# Increase the offset by 4 bytes (aka 32 bit)
		
		add	$t0,	$t0,	1	# Increase the current iteration count
		blt	$t0,	$t4,	main	# Make sure we aren't outside of the array 
		nop				# Avoid additional operation
		
		li	$v0,	10		# Load the exit code
		syscall				# Exit program
		
printElement:
		lw	$a0,	0($t3)		# Read the word from the address with an offset of 0 (we already added offset)
		li	$v0,	1		# Add the code for print integer
		syscall
		
		lw	$a0,	lf		# Add a newline (linefeed) character
		li	$v0,	11		# Add the code for print character
		syscall				
		jr	$ra			# Return from jump
		nop				# Avoid additional operation
		
sort:
	# Init the counters
	li	$s0,	0			# Outer pointer
	li	$s1,	0			# Inner pointer
	
sloop:
	li	$s2,	0			# Reset pointer
	li	$s3,	0			# Reset pointer
	
	mul	$s2,	$s0,	4		# Multiply outer pointer by 4, storing the address of a value in pointer $s2
	mul	$s3,	$s1,	4		# Multiply inner pointer by 4, storing the address of a value in pointer $s3
	
	add 	$s2,	$t1,	$s2		# Add the adress list to the pointer $s2, store in $s2 
	add 	$s3,	$t1,	$s3		# Add the adress list to the pointer $s3, store in $s3
	
	lw	$s4,	0($s2)			# Load contents of $s2 to $s4 (no offset)
	lw	$s5,	0($s3)			# Load contents of $s3 to $s5 (no offset)
	blt 	$s4,	$s5,	noswap		# Check if $s4 is less than $s5. If true, branch to label noswap
	nop					# Avoid additional operation
	
	# Swap values
	sw	$s5,	0($s2)			# Store content of $s2 in $s5
	sw	$s4,	0($s3)			# Store content of $s3 in $s4
	
noswap:
	add 	$s1,	$s1,	1		# Increment address pointer by 1
	
	blt 	$s1,	$t4	sloop		# Check if the inner pointer < lenght of the data list. If true, perform a new loop
	nop					# Avoid additional operation
	
	add 	$s0,	$s0,	1		# Increment Outer pointer by 1
	blt	$s0,	$t4,	sloop		# Check if the outer pointer < length of the data list. If true, perform a new loop. Next statement will be executed.
	add 	$s1,	$s0,	$0		# Overwrite value of Inner pointer with the Outer pointer to avoid iterating over old values
	
	jr 	$ra				# Return from jump
	nop					# Avoid additional operation
	
	b
