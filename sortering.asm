
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

# -------- Register list ---------
#	$t0	Temporary variable (tmp)
#	
#	$s0	Base pointer to the data
#	
#	$s1	Index of left (left)
#	$s2	Index of right (right)
#	
#	$s3	Value of left (left_data)
#	$s4	Value of right (right_data)
#	
#	$s5	Index of last element (length - 1)


# initialization code
init:
	la	$s0, data		# load address of data into base pointer
	li	$s1, 0		# initiate left to 0
	li	$s2, 0		# initiate right to 0
	lw	$s5, datalen 	# load length of data
	subi	$s5, $s5, 1		# subtract one to get last index

# main entry point. will be run only once before handing over control to the loops
main:
	beq	$s5, 1, exit	# exit if list only has one item
	# branch delay slot. row below will be performed even on branch!
	# read data into left_data
	sll	$t0, $s1, 2		# calculate offset (tmp = left * 4)
	addu	$t0, $s0, $t0	# add base ptr and offset to get proper address
	lw	$s3,($t0)		# left_data = data[left]
	
	b	inner			# enter inner loop
	# branch delay slot. row below will be performed even on branch!
	nop

# outer loop that uses left index
outer:
	# print left_data and a newline
	move	$a0, $s3		# argument0 = left_data
	li	$v0, 1		# v0 = 1 (print integer)
	syscall
	li	$a0, 10		# argument0 = 10 (ascii newline)
	li	$v0, 11		# v0 = 11 (print character)
	syscall

	addi	$s1, $s1, 1		# ++left
	beq	$s1, $s5, exit	# exit if left is at end of list
	# branch delay slot. row below will be performed even on branch!
	# read data into left_data
	sll	$t0, $s1, 2		# calculate offset (tmp = left * 4)
	addu	$t0, $s0, $t0	# add base ptr and offset to get proper address
	lw	$s3,($t0)		# left_data = data[left]
	
	b	inner			# enter inner loop
	# branch delay slot. row below will be performed even on branch!
	move	$s2, $s1		# right = left

# inner loop that uses right index
inner:
	beq	$s2, $s5, outer	# exit loop if right is at end of list
	# branch delay slot. row below will be performed even on branch!
	addi	$s2, $s2, 1		# ++right
	
	sll	$t0, $s2, 2		# calculate offset (tmp = right * 4)
	addu	$t0, $s0, $t0	# add base ptr and offset to get proper address
	lw	$s4,($t0)		# right_data = data[right]
	
	blt	$s3, $s4, inner	# if(left_data < right_data) don't swap
	# branch delay slot. row below will be performed even on branch!
	
	# swap the values
	sll	$t0, $s2, 2		# calculate offset (tmp = right * 4)
	addu	$t0, $s0, $t0	# add base ptr and offset to get proper address
	sw	$s3, ($t0)		# data[right] = left_data
	
	sll	$t0, $s1, 2		# calculate offset (tmp = left * 4)
	addu	$t0, $s0, $t0	# add base ptr and offset to get proper address
	sw	$s4,($t0)		# data[left] = right_data
	
	b	inner			# iterate
	# branch delay slot. row below will be performed even on branch!
	move $s3, $s4		# left_data = right_data
	nop

# exit program
exit:
	ori $v0, $zero, 10      # Prepare syscall to exit program cleanly
	syscall                 # Bye!
