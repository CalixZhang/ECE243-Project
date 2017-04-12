###############################################################################
#########################      Pattern Functions      #########################
###############################################################################
.global pattern1
pattern1:

	subi sp,sp,4                       # downstrum prologue
	stw ra,0(sp)                       # downstrum prologue
	call downstrum                     #                             D
	ldw ra,0(sp)                       # downstrum epilogue
	addi sp,sp,4                       # downstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	subi sp,sp,4                       # downstrum prologue
	stw ra,0(sp)                       # downstrum prologue
	call downstrum                     #                             D
	ldw ra,0(sp)                       # downstrum epilogue
	addi sp,sp,4                       # downstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	subi sp,sp,4                       # downstrum prologue
	stw ra,0(sp)                       # downstrum prologue
	call downstrum                     #                             D
	ldw ra,0(sp)                       # downstrum epilogue
	addi sp,sp,4                       # downstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	subi sp,sp,4                       # downstrum prologue
	stw ra,0(sp)                       # downstrum prologue
	call downstrum                     #                             D
	ldw ra,0(sp)                       # downstrum epilogue
	addi sp,sp,4                       # downstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	ret

###############################################################################
.global pattern2
pattern2:

	subi sp,sp,4                       # downstrum prologue
	stw ra,0(sp)                       # downstrum prologue
	call downstrum                     #                             D
	ldw ra,0(sp)                       # downstrum epilogue
	addi sp,sp,4                       # downstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	subi sp,sp,4                       # upstrum prologue
	stw ra,0(sp)                       # upstrum prologue
	call upstrum                       #                             U
	ldw ra,0(sp)                       # upstrum epilogue
	addi sp,sp,4                       # upstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	subi sp,sp,4                       # downstrum prologue
	stw ra,0(sp)                       # downstrum prologue
	call downstrum                     #                             D
	ldw ra,0(sp)                       # downstrum epilogue
	addi sp,sp,4                       # downstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	subi sp,sp,4                       # upstrum prologue
	stw ra,0(sp)                       # upstrum prologue
	call upstrum                       #                             U
	ldw ra,0(sp)                       # upstrum epilogue
	addi sp,sp,4                       # upstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	ret

###############################################################################
.global pattern3
pattern3:

	subi sp,sp,4                       # upstrum prologue
	stw ra,0(sp)                       # upstrum prologue
	call upstrum                       #                             U
	ldw ra,0(sp)                       # upstrum epilogue
	addi sp,sp,4                       # upstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	subi sp,sp,4                       # upstrum prologue
	stw ra,0(sp)                       # upstrum prologue
	call upstrum                       #                             U
	ldw ra,0(sp)                       # upstrum epilogue
	addi sp,sp,4                       # upstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	subi sp,sp,4                       # upstrum prologue
	stw ra,0(sp)                       # upstrum prologue
	call upstrum                       #                             U
	ldw ra,0(sp)                       # upstrum epilogue
	addi sp,sp,4                       # upstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	subi sp,sp,4                       # upstrum prologue
	stw ra,0(sp)                       # upstrum prologue
	call upstrum                       #                             U
	ldw ra,0(sp)                       # upstrum epilogue
	addi sp,sp,4                       # upstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue	
	
	ret

###############################################################################
.global pattern4
pattern4:

	subi sp,sp,4                       # downstrum prologue
	stw ra,0(sp)                       # downstrum prologue
	call downstrum                     #                             D
	ldw ra,0(sp)                       # downstrum epilogue
	addi sp,sp,4                       # downstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue		
	
	subi sp,sp,4                       # downstrum prologue
	stw ra,0(sp)                       # downstrum prologue
	call downstrum                     #                             D
	ldw ra,0(sp)                       # downstrum epilogue
	addi sp,sp,4                       # downstrum epilogue	
	
	subi sp,sp,4                       # upstrum prologue
	stw ra,0(sp)                       # upstrum prologue
	call upstrum                       #                             U
	ldw ra,0(sp)                       # upstrum epilogue
	addi sp,sp,4                       # upstrum epilogue		
	
	subi sp,sp,4                       # downstrum prologue
	stw ra,0(sp)                       # downstrum prologue
	call downstrum                     #                             D
	ldw ra,0(sp)                       # downstrum epilogue
	addi sp,sp,4                       # downstrum epilogue	
	
	subi sp,sp,4                       # fullrest prologue
	stw ra,0(sp)                       # fullrest prologue
	call fullrest                      #                             -
	ldw ra,0(sp)                       # fullrest epilogue
	addi sp,sp,4                       # fullrest epilogue			
	
	subi sp,sp,4                       # downstrum prologue
	stw ra,0(sp)                       # downstrum prologue
	call downstrum                     #                             D
	ldw ra,0(sp)                       # downstrum epilogue
	addi sp,sp,4                       # downstrum epilogue	
	
	subi sp,sp,4                       # upstrum prologue
	stw ra,0(sp)                       # upstrum prologue
	call upstrum                       #                             U
	ldw ra,0(sp)                       # upstrum epilogue
	addi sp,sp,4                       # upstrum epilogue	
	
	ret
	
###############################################################################
#########################       Strum Functions       #########################
###############################################################################
.global downstrum
downstrum:
	
	subi sp,sp,4                       # forward prologue
	stw ra,0(sp)                       # forward prologue
	call forward                       # Strum down
	ldw ra,0(sp)                       # forward epilogue
	addi sp,sp,4                       # forward epilogue	
	
	subi sp,sp,4                       # backwardup prologue
	stw ra,0(sp)                       # backwardup prologue
	call backwardup                    # Strum up while retracting pick 
	ldw ra,0(sp)                       # backwardup epilogue
	addi sp,sp,4                       # backwardup epilogue

	subi sp,sp,4                       # timer prologue
	stw ra,0(sp)                       # timer prologue
	call TIMERA                        # Slow down strumming
	ldw ra,0(sp)                       # timer epilogue
	addi sp,sp,4                       # timer epilogue

	ret
	
###############################################################################
.global upstrum
upstrum:

	subi sp,sp,4                       # forwardup prologue
	stw ra,0(sp)                       # forwardup prologue
	call forwardup                     # Strum down while retracting pick
	ldw ra,0(sp)                       # forwardup epilogue
	addi sp,sp,4                       # forwardup epilogue	

	subi sp,sp,4                       # backward prologue
	stw ra,0(sp)                       # backward prologue
	call backward                      # Strum up
	ldw ra,0(sp)                       # backward epilogue
	addi sp,sp,4                       # backward epilogue

	subi sp,sp,4                       # backward prologue
	stw ra,0(sp)                       # backward prologue
	call backward                      # Strum up
	ldw ra,0(sp)                       # backward epilogue
	addi sp,sp,4                       # backward epilogue
	
	subi sp,sp,4                       # timer prologue
	stw ra,0(sp)                       # timer prologue
	call TIMERA                        # Slow down strumming
	ldw ra,0(sp)                       # timer epilogue
	addi sp,sp,4                       # timer epilogue
	
	ret

###############################################################################
.global fullrest
fullrest:

	subi sp,sp,4                       # rest prologue
	stw ra,0(sp)                       # rest prologue
	call rest                          # Hold position
	ldw ra,0(sp)                       # rest epilogue
	addi sp,sp,4                       # rest epilogue
	
	subi sp,sp,4                       # timer prologue
	stw ra,0(sp)                       # timer prologue
	call TIMERA                        # Slow down strumming
	ldw ra,0(sp)                       # timer epilogue
	addi sp,sp,4                       # timer epilogue
	
	ret
	
###############################################################################
#########################      Strum Motor Moves      #########################
###############################################################################
.global forward
forward:

    movia r9, 0xFFFFFFF2               # Motor 0 goes forward
    stwio r9, 0(r8)                    # Reset to the original values

	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	ret

###############################################################################
.global forwardup
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
.global backward
backward:

    movia r9, 0xFFFFFFF0               # Motor 0 goes backward 
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
.global backwardup
backwardup:
	
    movia r9, 0xFFFFFFF8               # Motor 0 goes backward
    stwio r9, 0(r8)                    # Reset to the original value

	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
    movia r9, 0xFFFFFFFF               # Motor 0 does nothing
    stwio r9, 0(r8)                    # Reset to the original value

	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	#subi sp,sp,4                       # Timer prologue
	#stw ra,0(sp)                       # Timer prologue	
	#call TIMERB                        # Call the timer subroutine
	#ldw ra,0(sp)                       # Timer epilogue
	#addi sp,sp,4                       # Timer epilogue
	
	#subi sp,sp,4                       # Timer prologue
	#stw ra,0(sp)                       # Timer prologue	
	#call TIMERB                        # Call the timer subroutine
	#ldw ra,0(sp)                       # Timer epilogue
	#addi sp,sp,4                       # Timer epilogue
	
	ret

###############################################################################
.global rest
rest:

    movia r9, 0xFFFFFFFF               # Motor 0 does nothing
    stwio r9, 0(r8)                    # Reset to the original value
	
	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
    movia r9, 0xFFFFFFFF               # Motor 0 does nothing
    stwio r9, 0(r8)                    # Reset to the original value

	subi sp,sp,4                       # Timer prologue
	stw ra,0(sp)                       # Timer prologue	
	call TIMERB                        # Call the timer subroutine
	ldw ra,0(sp)                       # Timer epilogue
	addi sp,sp,4                       # Timer epilogue
	
	ret
	
###############################################################################
#########################            Timers           #########################
###############################################################################
.global TIMERA
TIMERA:

	#stack
	subi sp,sp,8
	stw r8,0(sp)
	stw r9,4(sp)
	
initWaitA:     #initialize timer

    movia r8, TIMER1_ADDR
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
.global TIMERB
TIMERB:

	#stack
	subi sp,sp,8
	stw r8,0(sp)
	stw r9,4(sp)
	
initWaitB:     #initialize timer

    movia r8, TIMER1_ADDR
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
