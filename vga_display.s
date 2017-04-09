###############################################################
#### GLOBAL AND CONSTANT DECLARATIONS
###############################################################
.global ADDR_CHAR
.global ADDR_PUSHBUTTONS
.global DRAW_INDICATOR_CTRL

.equ ADDR_CHAR, 0x09000000
.equ ADDR_PUSHBUTTONS, 0xFF200050

.equ FIRST_OFFSET_1, 1290
.equ FIRST_OFFSET_2, 1291
.equ FIRST_OFFSET_3, 1292

.equ SECOND_OFFSET_1, 1674
.equ SECOND_OFFSET_2, 1675
.equ SECOND_OFFSET_3, 1676

.equ THIRD_OFFSET_1, 2058
.equ THIRD_OFFSET_2, 2059
.equ THIRD_OFFSET_3, 2060

.equ FOURTH_OFFSET_1, 2442
.equ FOURTH_OFFSET_2, 2443
.equ FOURTH_OFFSET_3, 2444

###############################################################
#### PUSH BUTTON INTERRUPTS
###############################################################
.section .exceptions, "ax"

ISR:

# PROLOGUE
	subi	sp, sp, 80			       # allocate room on stack for reg
	stw		ea, 0(sp)			       # begin storing registors
	stw		et, 4(sp)			       # store present value of et
	rdctl	et, ctl1			       # Interpret value of ct11 into et
	stw		et, 8(sp)			       # store modified value of et
	
	stw		r2, 12(sp)			       # store gp registers
	stw		r3, 16(sp)
	stw		r4, 20(sp)
	stw		r5, 24(sp)
	stw		r6, 28(sp)
	stw		r7, 32(sp)
	stw		r8, 36(sp)
	stw		r9, 40(sp)
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
	bne		r16, r0, ISR_HANDLER	   # if 1st bit not 0, continue
	
# HANDLERS
ISR_HANDLER: 
	/* r2 - addr of pushbutton
	   r3 - addr of prev_state
	   r4 - addr of curr_state
	   r10 - state comparator
	   r12 - value of prev_state
	   r13 - value of curr_state
	*/

	movia r2, ADDR_PUSHBUTTONS
	ldwio r11, 0(r2)			# read button value into r11
	movia r3, prev_state
	ldw r12, 0(r3)				# read prev_value into r12
	movia r4, curr_state			
	ldw r13, 0(r4)				# read curr_state into r13
	
	movi r10, 0
	beq r13, r10, STATE0		# if curr_state = 0
	movi r10, 1
	beq r13, r10, STATE1		# if curr_state = 1
	movi r10, 2	
	beq r13, r10, STATE2		# if curr_state = 2
	movi r10, 3
	beq r13, r10, STATE3		# if curr_state = 3
	
	br ISREnd
	
STATE0:	
	stw r13, 0(r3)				# change prev_state to curr_state
	movi r13, 1					# new curr_state = 1
	stw r13, 0(r4)				# store new curr_state value
	
	br ISREnd
	
STATE1:
	stw r13, 0(r3)				# store curr_state to prev_state
	movi r13, 2					# new curr_state = 2
	stw r13, 0(r4)				# store new curr_state value
	
	br ISREnd
	
STATE2:
	stw r13, 0(r3)				# store curr_state to prev_state
	movi r13, 3					# new curr_state = 3
	stw r13, 0(r4)				# store new curr_state value
	
	br ISREnd
	
STATE3:
	stw r13, 0(r3)				# store curr_state to prev_state
	movi r13, 0					# new curr_state = 0
	stw r13, 0(r4)				# store new curr_state value
	
	br ISREnd
	
ISREnd:
	movi r5, 0x02
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
	ldw		r8, 36(sp)
	ldw		r9, 40(sp)
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
	


###############################################################
#### DATA SECTION
###############################################################

.data
prev_state:		# previous state - ???????
	.word  0

curr_state:		# current state - used to determine next state
	.word 0

.text
###############################################################
#### DRAWING START
###############################################################

/*	r2 - addr of pushbutton
	r3 - address of VGA character buffer
	r4 - addr of curr_state variable
	r5 - ASCII codes of characters to be drawn
	r6 - counter for buffer offset
	r7 - max value of buffer offset
	r8 - value of curr_state
	r9 - state comparator
*/

.global _start
_start:

# ENABLE INTERRUPTS
	movia r2,ADDR_PUSHBUTTONS
	movi r3,0x02	  # Enable interrrupt mask = 0010
	stwio r3,8(r2)  # Enable interrupts on pushbutton(s) 1
	stwio r3,12(r2) # Clear edge capture register to prevent unexpected interrupt

	movi r2,0x02	# 0...10
	wrctl ctl3,r2   # Enable bit 1 - Pushbuttons use IRQ 1

	movia r2,1
	wrctl ctl0,r2   # Enable global Interrupts on Processor
	
# INITIALIZE COUNTERS FOR CLEAR_SCREEN
	movi r6, 0		# offset counter
	movi r7, 7632 	# max offset
	br CLEAR_SCREEN

CLEAR_SCREEN:

	# Clears entire screen
	movia r3, ADDR_CHAR
	movi r5, SPACE
	stbio r5, 0(r3)
	addi r3, r3, 1
	addi r6, r6, 1
	bne r6, r7, CLEAR_SCREEN
	
	br DRAW_TITLE
		
DRAW_INDICATOR_CTRL:
	movia r4, curr_state			# create pointer to curr_state variable
	ldw r8, 0(r4)					# load value of curr_state to r8
	
	movi r9, 0						# state comparator
	beq r8, r9, DRAW_INDICATOR_1	# if state = 0 -> draw indicator at 1.
	movi r9, 1						# state comparator
	beq r8, r9, DRAW_INDICATOR_2	# if state = 1 -> draw indicator at 2.
	movi r9, 2						# state comparator
	beq r8, r9, DRAW_INDICATOR_3	# if state = 2 -> draw indicator at 3.
	movi r9, 3						# state comparator
	beq r8, r9, DRAW_INDICATOR_4	# if state = 3 -> draw indicator at 4.
	
	br DRAW_INDICATOR_CTRL

DRAW_INDICATOR_1:
	movia r3, ADDR_CHAR
	
	movi r5, SPACE
	stbio r5, FOURTH_OFFSET_1(r3)	
	stbio r5, FOURTH_OFFSET_2(r3)
	stbio r5, FOURTH_OFFSET_3(r3)
	
	movi r5, GREATER
	stbio r5, FIRST_OFFSET_1(r3)	
	stbio r5, FIRST_OFFSET_2(r3)
	stbio r5, FIRST_OFFSET_3(r3)
	br DRAW_INDICATOR_CTRL

DRAW_INDICATOR_2:
	movia r3, ADDR_CHAR
	
	movi r5, SPACE
	stbio r5, FIRST_OFFSET_1(r3)	
	stbio r5, FIRST_OFFSET_2(r3)
	stbio r5, FIRST_OFFSET_3(r3)
	
	movi r5, GREATER
	stbio r5, SECOND_OFFSET_1(r3)	
	stbio r5, SECOND_OFFSET_2(r3)
	stbio r5, SECOND_OFFSET_3(r3)
	br DRAW_INDICATOR_CTRL
	
DRAW_INDICATOR_3:
	movia r3, ADDR_CHAR
	
	movi r5, SPACE
	stbio r5, SECOND_OFFSET_1(r3)	
	stbio r5, SECOND_OFFSET_2(r3)
	stbio r5, SECOND_OFFSET_3(r3)
	
	movi r5, GREATER
	stbio r5, THIRD_OFFSET_1(r3)	
	stbio r5, THIRD_OFFSET_2(r3)
	stbio r5, THIRD_OFFSET_3(r3)
	br DRAW_INDICATOR_CTRL
	
DRAW_INDICATOR_4:
	movia r3, ADDR_CHAR
	
	movi r5, SPACE
	stbio r5, THIRD_OFFSET_1(r3)	
	stbio r5, THIRD_OFFSET_2(r3)
	stbio r5, THIRD_OFFSET_3(r3)
	
	movi r5, GREATER
	stbio r5, FOURTH_OFFSET_1(r3)	
	stbio r5, FOURTH_OFFSET_2(r3)
	stbio r5, FOURTH_OFFSET_3(r3)
	br DRAW_INDICATOR_CTRL
	
LOOP:
	
	br LOOP
	