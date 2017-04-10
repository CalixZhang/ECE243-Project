.global _start

###############################################################################
#########################        Main Functions       #########################
###############################################################################

_start:

	# Initialize Stack
	orhi sp, zero, 0x400
	addi sp, sp, 0x0
	nor sp, sp, sp
	ori sp, sp, 0x7
	nor sp, sp, sp
  
	.equ JP1, 0xFF200060               # Lego JP1 Address
	.equ TIMER1ADDRESS , 0xFF202000    # Timer 1 Address
	movia r8, JP1                      # Store this value to register 8
	
    movia r9, 0xFFFFFFFF               # Set everything to off 
    stwio r9, 0(r8)                    # Reset to the original value
	movia r9, 0x07F557FF               # Set direction for motors and sensors 
	stwio r9, 4(r8)                    # to output and sensor data register to inputs

###############################################################################

loopforever:

	call forwardup
	
	call backward
	
	call TIMERA
	
	br loopforever                     # Loop forever


###############################################################################
#########################       Strum Functions       #########################
###############################################################################
downstrum:

	call forward
	
	call backwardup
	
	call TIMERA
	
	ret
	
###############################################################################

upstrum:

	call forwardup
	
	call backward
	
	call TIMERA
	
	ret
	
###############################################################################
#########################      Strum Motor Moves      #########################
###############################################################################

forward:

    movia r9, 0xFFFFFFFE               # Motor 0 goes forward
    stwio r9, 0(r8)                    # Reset to the original value
	
	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
    movia r9, 0xFFFFFFFF               # Motor 0 does nothing.
    stwio r9, 0(r8)                    # Reset to the original value

	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	ret

###############################################################################

forwardup:
	
    movia r9, 0xFFFFFFFA               # Motor 0 goes forward
    stwio r9, 0(r8)                    # Reset to the original value

	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
    movia r9, 0xFFFFFFFF               # Motor 0 does nothing.
    stwio r9, 0(r8)                    # Reset to the original value

	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	ret

###############################################################################

backward:

    movia r9, 0xFFFFFFFC               # Motor 0 goes backward 
    stwio r9, 0(r8)                    # Reset to the original value
	
	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
    movia r9, 0xFFFFFFFF               # Motor 0 does nothing.
    stwio r9, 0(r8)                    # Reset to the original value

	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	ret
	
###############################################################################

backwardup:
	
    movia r9, 0xFFFFFFF8               # Motor 0 goes backward
    stwio r9, 0(r8)                    # Reset to the original value

	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
    movia r9, 0xFFFFFFFF               # Motor 0 does nothing.
    stwio r9, 0(r8)                    # Reset to the original value

	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	ret
	
###############################################################################
#########################            Timers           #########################
###############################################################################

TIMERA:

	#stack
	subi sp,sp,8
	stw r8,0(sp)
	stw r9,4(sp)
	
initWaitA:     #initialize timer

    movia r8, TIMER1ADDRESS
    addi  r9, r0, 0x8                   # stop the counter
    stwio r9, 4(r8)
 
    # Set the period registers to 10^7
    addi  r9, r0, %lo(40000000)
    stwio r9, 8(r8)
    addi  r9, r0, %hi(40000000)
    stwio r9, 12(r8)
	  
	movi        r9, 0x0             # clear the TO bit
    stwio       r9, 0(r8)
	
	# tell the counter to start over automatically and start counting
    addi  r9, r0, 0x4                   # 0x6 = 0110 so we write 1 to START and to CONT
    stwio r9, 4(r8)
		
timeLoopA:     #looping to check the condition	

    ldwio       r9, 0(r8)   # check if the TO bit of the status register is 1
    andi        r9, r9, 0x1
    beq         r9, r0, timeLoopA        
    
	# stop the counter before exiting
    movi        r9, 8         
    stwio       r9, 4(r8)
	ldw r8,0(sp)
	ldw r9,4(sp)
	addi sp,sp,8
	
	ret

###############################################################################

TIMERB:

	#stack
	subi sp,sp,8
	stw r8,0(sp)
	stw r9,4(sp)
	
initWaitB:     #initialize timer

    movia r8, TIMER1ADDRESS
    addi  r9, r0, 0x8                   # stop the counter
    stwio r9, 4(r8)
 
    # Set the period registers to 10^7
    addi  r9, r0, %lo(8000000)
    stwio r9, 8(r8)
    addi  r9, r0, %hi(8000000)
    stwio r9, 12(r8)
	  
	movi        r9, 0x0             # clear the TO bit
    stwio       r9, 0(r8)
	
	# tell the counter to start over automatically and start counting
    addi  r9, r0, 0x4                   # 0x6 = 0110 so we write 1 to START and to CONT
    stwio r9, 4(r8)
		
timeLoopB:     #looping to check the condition	

    ldwio       r9, 0(r8)   # check if the TO bit of the status register is 1
    andi        r9, r9, 0x1
    beq         r9, r0, timeLoopB       
    
	# stop the counter before exiting
    movi        r9, 8         
    stwio       r9, 4(r8)
	ldw r8,0(sp)
	ldw r9,4(sp)
	addi sp,sp,8
	
	ret

###############################################################################
	
