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

.equ SECOND_OFFSET_1, 1678
.equ SECOND_OFFSET_2, 1679
.equ SECOND_OFFSET_3, 1680

.equ THIRD_OFFSET_1, 2062
.equ THIRD_OFFSET_2, 2063
.equ THIRD_OFFSET_3, 2064

.equ FOURTH_OFFSET_1, 2446
.equ FOURTH_OFFSET_2, 2447
.equ FOURTH_OFFSET_3, 2448

###############################################################
#### PUSH BUTTON INTERRUPTS
###############################################################
.section .exceptions, "ax"

ISR:
	


###############################################################
#### DATA SECTION
###############################################################

.data
prev_state:
	.word  0

curr_state:
	.word 0

.text
###############################################################
#### DRAWING START
###############################################################

/*	r3 - address of character buffer
	r5 - ASCII code of character to be drawn
	r6 - counter for buffer offset
	r7 - max value of buffer offset
*/

.global _start
_start:

# ENABLE INTERRUPTS
	movia r2,ADDR_PUSHBUTTONS
	movia r3,0x02	  # Enable interrrupt mask = 0010
	stwio r3,8(r2)  # Enable interrupts on pushbutton(s) 1
	stwio r3,12(r2) # Clear edge capture register to prevent unexpected interrupt

	movia r2,0x02	# 0...10
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
	

DRAW_INDICATOR_1:
	movia r3, ADDR_CHAR
	movi r5, GREATER
	stbio r5, FIRST_OFFSET_1(r3)	
	stbio r5, FIRST_OFFSET_2(r3)
	stbio r5, FIRST_OFFSET_3(r3)
	br POLL_INPUT

DRAW_INDICATOR_2:
	movia r3, ADDR_CHAR
	movi r5, GREATER
	stbio r5, SECOND_OFFSET_1(r3)	
	stbio r5, SECOND_OFFSET_2(r3)
	stbio r5, SECOND_OFFSET_3(r3)
	br POLL_INPUT
	
DRAW_INDICATOR_3:
	movia r3, ADDR_CHAR
	movi r5, GREATER
	stbio r5, THIRD_OFFSET_1(r3)	
	stbio r5, THIRD_OFFSET_2(r3)
	stbio r5, THIRD_OFFSET_3(r3)
	br POLL_INPUT
	
DRAW_INDICATOR_4:
	movia r3, ADDR_CHAR
	movi r5, GREATER
	stbio r5, FOURTH_OFFSET_1(r3)	
	stbio r5, FOURTH_OFFSET_2(r3)
	stbio r5, FOURTH_OFFSET_3(r3)
	br POLL_INPUT
	
POLL_INPUT:
	
	br POLL_INPUT
	