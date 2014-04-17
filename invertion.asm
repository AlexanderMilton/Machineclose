
    # InVertion Sorting Algorithm
     
.data
     
datalen:
	.word   0x0010  	# 16
	
data:
	.word   0xffff7e81
	.word   0x00000001
	.word   0x00000002
	.word   0xffff0001
	.word   0x00000000
	.word   0x00000001
	.word   0xffffffff
	.word   0x00000000
	.word   0xe3456687
	.word   0xa001aa88
	.word   0xf0e159ea
	.word   0x9152137b
	.word   0xaab385a1
	.word   0x31093c54
	.word   0x42102f37
	.word   0x00ee655b

.text

	#########################################################################################
	#											#
	#		(>^_^)>		THE GREAT REGISTER LIST		<(^_^<)			#
	#											#
	#	$t0	Temporary variable (unsuitable for anything but temporary operations	#
	#	$s0	Base pointer to the data address list					#
	#	$s1	Index of left value to compare						#
	#	$s2	Index of right value to compare						#
	#	$s3	Address of left value to compare					#
	#	$s4	Address of right value to compare					#
	#	$s5	The length of the data array						#
	#											#
	#		(>^_^)>		THE GREAT REGISTER LIST		<(^_^<)			#
	#											#
	#########################################################################################



# initialization code
	la $s0, data		# Load address of data array into base pointer register
	li $s1, 0		# Initiate left index		OBSOLETE OPERATION
	li $s2, 1		# Initiate right index
	li $s3, 0		# Initiate left value		OBSOLETE OPERATION
	li $s4, 0		# Initiate right value		OBSOLETE OPERATION
	la $s5, datalen		# Initiate data length value

# main loop
iterate:
	beq $s2, $s5, print	# If the right index has reached the end of the data list we print the newly sorted value and increment the left index
	nop			# Avoid additional operation
	
	mul $s3, $s1, 4		# Multiply index by 4 (bytes) to recieve an address value
	mul $s4, $s2, 4		# Multiply index by 4 (bytes) to recieve an address value
	
	add $s3, $s3, $s0	# Add the data list to the value pointer, storing an address 
	add $s4, $s4, $s0	# Add the data list to the value pointer, storing an address
	
	lw $s3, 0($s3)		# Load the word value stored in the register (?)
	lw $s4, 0($s4)		# Load the word value stored in the register (?)
	
	blt $s3, $s4, iterate	# Reiterate if the left value is less than the right value,
	add $s2, $s2, 1		# increment right index by 1 before jumping
	
# swap the left and right appointed value
swap:
	la $t0, 0($s3)		# Load the word stored in $s3 to a temporary register
	la $s4, 0($s3)		# Load the word stored in $s3 to $s4
	la $s3, 0($t0)		# Load the word stored in the temporary register to $s3
	
	jal iterate		# Reiterate
	nop

# print latest sorted value
print:
	lw $a0, 0($s3)		# Add content of sorted value
	li $v0, 1               # Add service 1 (print integer) to $v0
	syscall                 # Syscall to print     
	
	lw $a0, 10		# Add a newline character (ascii value 10)
	li $v0, 11		# Add service 11 (print character)
	syscall			# Syscall to print
	
# increment indices 
increment:
	add $s1, $s1, 1		# Increment left index by 1
	
	beq $s1, $s5, exit	# If the left index has reached the end of the data list, exit
	nop			# (>^_^)> This line may be utilized to prepare operation?
	
	jal iterate		# Reiterate
	add $s2, $s1, 1		# Reset and increment right index before jumping
	
# exit program
exit:
	ori $v0, $zero, 10      # Prepare syscall to exit program cleanly
	syscall                 # Bye!



	#########################################################################################
	#											#
	#		(>^_^)>		THE GREAT REGISTER LIST		<(^_^<)			#
	#											#
	#	$t0	Temporary variable (unsuitable for anything but temporary operations	#
	#	$s0	Base pointer to the data address list					#
	#	$s1	Index of left value to compare						#
	#	$s2	Index of right value to compare						#
	#	$s3	Address of left value to compare					#
	#	$s4	Address of right value to compare					#
	#	$s5	The length of the data array						#
	#											#
	#		(>^_^)>		THE GREAT REGISTER LIST		<(^_^<)			#
	#											#
	#########################################################################################
