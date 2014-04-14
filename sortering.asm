	

    # Maskinnara programmering, program template
     
    .data
     
    datalen:
            .word   0x0010  # 16
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
# initialization code

# main loop
    main:

# exit program
    exit:
            ori $v0, $zero, 10      # Prepare syscall to exit program cleanly
            syscall                 # Bye!

# print a newline
    newline:
            li $v0, 11			# Add service 11 (print character) to $v0
            move $a0, 10		# Move newline character to parameter
            syscall			# Syscall to print newline character
            jr $ra

# prints content of a0
    print_int:
            li $v0, 1               # Add service 1 (print integer) to $v0
            syscall                 # Syscall to print parameter value        
            jr $ra			# Jump back
