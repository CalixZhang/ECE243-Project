.equ ADDR_VGA, 0x08000000	# pixel buffer
.equ ADDR_CHAR, 0x09000000	# char buffer

.global _start
_start:
	movia r2, ADDR_VGA
	movia r3, ADDR_CHAR
	movui r4, 0xffff
	movi r5, 0x41
	sthio r4, 1032(r2)
	stbio r5, 132(r3)
