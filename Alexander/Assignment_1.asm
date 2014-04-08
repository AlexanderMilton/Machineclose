	#
	# Maskinnara programmering, program template

.data
	a: .word 5
	b: .word 10
	c: .word 
.text
	lw $t0, a			# Load word
	lw $t1, b			# Load word	
	lw $t2, c			# Load word
main:
	add $t2, $t0, $t1

	li  $v0, 1			# service 1 is print integer
	move $a0, $t2 			# move desired value into argument register $a0, using pseudo-op
	syscall
	
	ori $v0, $zero, 10		# Prepare syscall to exit program cleanly
	syscall				# Bye!
