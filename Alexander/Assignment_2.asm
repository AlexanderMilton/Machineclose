# Maskinnara programmering, Assignment 2

.data

.text
main:

L:
	lw   $5, 0($4)		# Load word stored in $4 into address $3
	addi $2, $2, 1		# Add value 1 to register at $2, store result in $2
	sw   $3, 0($5)		# Store word at address $5 in $3
	addi $4, $4, 1		# Add value 1 to register at $4, store result in $4
	addi $5, $5, 1		# Add value 1 to register at $5, store result in $5
	bne  $4, 0, L		# Branch to L if register $4 != 0
	nop
	
	li  $v0, 1		# service 1 is print integer
	move $a0, $2 		# move desired value into argument register $a0, using pseudo-op
	syscall
    
	ori $v0, $zero, 10	# Prepare syscall to exit program cleanly
	syscall			# Bye!

