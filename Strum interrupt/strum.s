.equ ADDR_CHAR, 0x09000000			# VGA character buffer 
.equ ADDR_PUSHBUTTONS, 0xFF200050	# DE1-SoC board pushbuttons
.equ JP1, 0xFF200060               	# Lego JP1 Address
.equ TIMER1_ADDR , 0xFF202000    	# Timer 1 Address


###############################################################
#### PUSH BUTTON INTERRUPTS
###############################################################
.section .exceptions, "ax"

PB_ISR:

# PROLOGUE
	subi	sp, sp, 80			       # allocate room on stack for reg
	stw		ea, 0(sp)			       # begin storing registers
	stw		et, 4(sp)			       # store present value of et
	rdctl	et, ctl1			       # Interpret value of ct11 into et
	stw		et, 8(sp)			       # store modified value of et
	
	stw		r2, 12(sp)			       # store gp registers
	stw		r3, 16(sp)
	stw		r4, 20(sp)
	stw		r5, 24(sp)
	stw		r6, 28(sp)
	stw		r7, 32(sp)
	stw		r12, 36(sp)
	stw		r13, 40(sp)
	stw		r10, 44(sp)
	stw		r11, 48(sp)
	stw		r12, 52(sp)
	stw		r13, 56(sp)
	stw		r14, 60(sp)
	stw		r15, 64(sp)
	stw		ra, 68(sp)
	stw		r16, 72(sp)
	stw		r17, 76(sp)
	
# CHECK WHICH INTERRUPT
	rdctl	r16, ctl4				   # Interpret current value of ct14
	andi	r16, r16, 0x02			   # check for IRQ 1, PUSHBUTTONS
	bne		r16, r0, PB_ISR_HANDLER	   # if 1st bit not 0, continue
	
# HANDLERS
PB_ISR_HANDLER: 
	/* r2 - addr of pushbutton
	   r3 - addr of prev_state
	   r4 - addr of curr_state
	   r5 - addr of play_state
	   r13 - button value comparator
	   r10 - state comparator
	   r12 - value of prev_state
	   r13 - value of curr_state
	   r14 - value of play_state
	   r15 - play_state comparator
	*/

	movia r2, ADDR_PUSHBUTTONS
	ldwio r11, 0(r2)			# read button value into r11
	#movi r13, 0x02
	#beq r13, r11, STATE_CTRL		# if KEY1 is pressed, change state
	movi r13, 0x01
	beq r13, r11, PLAY_CTRL		# if KEY0 is pressed, change playing state
	
	br PB_ISREnd

PLAY_CTRL:
	movia r5, play_state		# r5 = ptr to play_state
	ldw r14, 0(r5)				# load play_state into r14
	
	movi r13, 0
	beq r14, r13, STOP			# if play_state = STOP, change to STOP
	
	br PLAY

STOP:							# current state = STOP
	movi r14, 1					# set play_state = 1
	ldw r14, 0(r5)				# change value of play_state
	br PB_ISREnd

PLAY:
	movi r14, 0					# set play_state = 0
	ldw r14, 0(r5)				# change value of play_state
	br PB_ISREnd				# change value of play_state
	

	
PB_ISREnd:
	movi r5, 0x01
	stwio r5, 12(r2) 			# Clear edge capture register to prevent unexpected interrupt
	
# EPILOGUE
	ldw		ea, 0(sp)
	ldw		et, 8(sp)	
	wrctl	ctl1, et	
	ldw		et, 4(sp)	
	ldw		r2, 12(sp)
	ldw		r3, 16(sp)
	ldw		r4, 20(sp)
	ldw		r5, 24(sp)
	ldw		r6, 28(sp)
	ldw		r7, 32(sp)
	ldw		r12, 36(sp)
	ldw		r13, 40(sp)
	ldw		r10, 44(sp)
	ldw		r11, 48(sp)
	ldw		r12, 52(sp)
	ldw		r13, 56(sp)
	ldw		r14, 60(sp)
	ldw		r15, 64(sp)
	ldw		ra, 68(sp)
	ldw		r16, 72(sp)
	ldw		r17, 76(sp)
	addi	sp, sp, 80
	subi	ea, ea, 4		# resume execution of old instruction
	eret

###############################################################################
#### DATA SECTION
###############################################################################
.data
play_state:
.word 0




.text
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
  
	#.equ JP1, 0xFF200060               # Lego JP1 Address
	#.equ TIMER1_ADDR , 0xFF202000    # Timer 1 Address
	movia r8, JP1                      # Store this value to register 8
	
    movia r9, 0xFFFFFFFF               # Set everything to off 
    stwio r9, 0(r8)                    # Reset to the original value
	movia r9, 0x07F557FF               # Set direction for motors and sensors 
	stwio r9, 4(r8)                    # to output and sensor data register to inputs
	
	movia r2,ADDR_PUSHBUTTONS
	movi r3,0x01	# Enable interrrupt mask = 0011
	stwio r3,8(r2)  # Enable interrupts on pushbutton(s) 0,1
	stwio r3,12(r2) # Clear edge capture register to prevent unexpected interrupt

	movi r2,0x02	# 0...10
	wrctl ctl3,r2   # Enable bit 1 - Pushbuttons use IRQ 1

	movia r2,1
	wrctl ctl0,r2   # Enable global Interrupts on Processor

###############################################################################
poll:
	movia r3, play_state
	ldw r5, 0(r3)
	movi r6, 1
	beq r5, r6, play
	
	br poll

play:
	call pattern2
	
	movia r3, play_state
	ldw r5, 0(r3)
	movi r6, 1
	beq r5, r6, play                   # Loop forever


###############################################################################
#########################      Pattern Functions      #########################
###############################################################################

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