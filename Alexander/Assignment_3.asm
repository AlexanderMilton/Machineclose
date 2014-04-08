# Maskinnara programmering, program template

.data
	counter: .word 0
	linebreak: .word 10
	msg: .asciiz "Enter a number to view its multiplication table: "
	
.text

main:

initialize:

	# Store counter
	lw $t0 counter		# Store a loop counter at $t0
	lw $t4 linebreak	# Store new line ascii values at $t4
	la $a0, msg		# Load address of ascii-string msg to $a0
	li $v0, 4		# Add service 4 (print string) to $v0
	syscall			# Syscall to print  message
	

input:

	# Get input
	li $v0, 5		# Add service 5 (read integer) to $v0
	syscall			# Syscall to take input
	move $t1, $v0		# Store the input at $t1
	jal newline		# Jump to and link a line break


multiply_and_print:

	# Multiply
	mult $t1, $t0		# Multiply input value by counter 
	mflo $t2		# Store result (from lo register) at $t2
	
	# Print
	li $v0, 1       	# Add service 1 (print integer) to $v0
	move $a0, $t2      	# Move value to parameter
	syscall			# Syscall to print parameterd values
	
	# Counter
	add $t0, $t0, 1		# Increment counter by 1
	
	jal newline		# Jump to and link a line break
	
	# Check counter
	ble $t0, 12, multiply_and_print		# Branch back to "multiply" label if counter is less than or equal to 12
	jal terminate				# Jump to and link exit label
	
	
newline:
	
	# New line
	li $v0, 11		# Add service 11 (print character) to $v0
	move $a0, $t4		# Move newline character to parameter
	syscall			# Syscall to print newline character
	jr $ra
	
	
terminate:
	
	# Exit
	ori $v0, $zero, 10	# Prepare syscall to exit program cleanly
	syscall			# Bye!
	
	
