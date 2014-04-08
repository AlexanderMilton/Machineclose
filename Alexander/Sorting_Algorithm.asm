# Maskinnara programmering, program template

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

	int1: .word 4
	int2: .word 5
	int3: .word 2
	int4: .word 3
	int5: .word 1
	
	linebreak: .word 10	# 10 represents the ascii character for newline
	#msg: .asciiz ""
	
.text

main:

initialize:

	# Store data
	lw $t1 int1
	lw $t2 int2
	lw $t3 int3
	lw $t4 int4
	lw $t5 int5
	
	lw $t6 linebreak	# Store new line ascii value
	lw $t7 counter		# Store a counter
	#la $t msg		# Store ascii message, currently obsolete
	
	
terminate:
	
	# Exit
	ori $v0, $zero, 10	# Prepare syscall to exit program cleanly
	syscall			# Bye!
	
	
	
	

input:	# currently obsolete

	# Get integer input
	li $v0, 5		# Add service 5 (read integer) to $v0
	syscall			# Syscall to take input
	move $t1, $v0		# Store the input at $t1
	
	jr $ra
	
	
newline:
	
	# New line
	li $v0, 11		# Add service 11 (print character) to $v0
	move $a0, $t4		# Move newline character to parameter
	syscall			# Syscall to print newline character
	
	jr $ra
	

print:	# currently obsolete
	
	# Print
	li $v0, 1       	# Add service 1 (print integer) to $v0
	move $a0, $t7      	# Move value to parameter
	syscall			# Syscall to print parameterd values
	
	jr $ra

