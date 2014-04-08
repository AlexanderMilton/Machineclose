	#
	# Maskinnara programmering, program template

.data
	hw: .asciiz   "Hello World!"
.text
main:
	la   $a0,hw        #address to the string in a0
	li   $v0,4         #put 4 in v0 (print_string)
	syscall            #do a system call
	ori	$v0,$zero,10	# Prepare syscall to exit program cleanly
	syscall			# Bye!
