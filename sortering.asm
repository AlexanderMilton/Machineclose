
    # InVertion Sorting Algorithm
     
.data
	
datalen2:
	.word		0x0001
data2:
	.word		0x009
	.word		0x000
	.word		0x007
	.word		0x001
	.word		0x003
	.word		0x004
	.word		0x002
	.word		0x006
	.word		0x008
	.word		0x005

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

# -------- Register list ---------
#	$s1	Index of left (left)
#	$s2	Index of right (right)
#	
#	$s3	Value of left (left_data)
#	$s4	Value of right (right_data)
#
#	$s5	Memory address of left_data (left_addr)
#	$s6	Memory address of right_data (right_addr)
#	
#	$s7	Index of last element (length - 1)

# main entry point. will be run only once before handing over control to the loops
main:
	li	$s1, 0		# initialise left to 0
	li	$s2, 0		# initialise right to 0
	lw	$s7, datalen 	# load length of data
	subi	$s7, $s7, 1		# subtract one from length to get last index

	# read data into left_data
	la	$s5, data		# left_addr = start of data
	lw	$s3,($s5)		# left_data = data[left_addr]
	
	b	inner			# enter inner loop
	# branch delay slot. row below will be performed even on branch!
	move $s6, $s5		# right_addr = left_addr

# outer loop that uses left index
outer:
	# print left_data and a newline
	move	$a0, $s3		# argument0 = left_data
	li	$v0, 1		# v0 = 1 (print integer)
	syscall
	li	$a0, 10		# argument0 = 10 (ascii newline)
	li	$v0, 11		# v0 = 11 (print character)
	syscall

	beq	$s1, $s7, exit	# exit if left is at end of list
	# branch delay slot. row below will be performed even on branch!
	addi	$s1, $s1, 1		# ++left

	# read data into left_data
	addiu	$s5, $s5, 4		# move left address pointer to next word (left_addr += 4)
	lw	$s3,($s5)		# left_data = data[left_addr]
	
	move $s6, $s5		# right_addr = left_addr
	b	inner			# enter inner loop
	# branch delay slot. row below will be performed even on branch!
	move	$s2, $s1		# right = left

# inner loop that uses right index
inner:
	beq	$s2, $s7, outer	# exit loop if right is at end of list
	# branch delay slot. row below will be performed even on branch!
	addi	$s2, $s2, 1		# ++right
	
	addiu	$s6, $s6, 4		# move right address pointer to next word (right_addr += 4)
	lw	$s4,($s6)		# right_data = data[right_addr]
	
	blt	$s3, $s4, inner	# if(left_data < right_data) don't swap
	# branch delay slot. row below will be performed even on branch!
	nop
	# swap the values
	# right_addr is already updated above
	sw	$s3,($s6)		# data[right_addr] = left_data
	# left_addr has not been changed and is still correct
	sw	$s4,($s5)		# data[left_addr] = right_data
	
	b	inner			# iterate
	# branch delay slot. row below will be performed even on branch!
	move $s3, $s4		# left_data = right_data

# exit program
exit:
	ori $v0, $zero, 10      # Prepare syscall to exit program cleanly
	syscall                 # Adios!
