##################################################################
#### STATIC TEXT DRAWING FUNCTIONS
##################################################################

.global DRAW_TITLE
.global DRAW_PAT_INTRO
.global DRAW_FIRST_CHOICE
.global DRAW_SECOND_CHOICE
.global DRAW_THIRD_CHOICE
.global DRAW_FOURTH_CHOICE
	
DRAW_TITLE:
	# write title "GUITAR PLAYER" to top of display
	# first character displayed at (33, 2)
	movia r3, ADDR_CHAR
	movi r5, CHAR_G
	stbio r5, 289(r3)
	movi r5, CHAR_U
	stbio r5, 290(r3)
	movi r5, CHAR_I
	stbio r5, 291(r3)
	movi r5, CHAR_T
	stbio r5, 292(r3)
	movi r5, CHAR_A
	stbio r5, 293(r3)
	movi r5, CHAR_R
	stbio r5, 294(r3)
	
	movi r5, SPACE
	stbio r5, 295(r3)
	
	movi r5, CHAR_P
	stbio r5, 296(r3)
	movi r5, CHAR_L
	stbio r5, 297(r3)
	movi r5, CHAR_A
	stbio r5, 298(r3)
	movi r5, CHAR_Y
	stbio r5, 299(r3)
	movi r5, CHAR_E
	stbio r5, 300(r3)
	movi r5, CHAR_R
	stbio r5, 301(r3)
	
	br DRAW_PAT_INTRO

DRAW_PAT_INTRO: # "Select a Pattern:"

	movia r3, ADDR_CHAR
	movi r5, CHAR_S
	stbio r5, 778(r3)
	movi r5, CHAR_e
	stbio r5, 779(r3)
	movi r5, CHAR_l
	stbio r5, 780(r3)
	movi r5, CHAR_e
	stbio r5, 781(r3)
	movi r5, CHAR_c
	stbio r5, 782(r3)
	movi r5, CHAR_t
	stbio r5, 783(r3)
	movi r5, SPACE
	stbio r5, 784(r3)
	movi r5, CHAR_A
	stbio r5, 785(r3)
	movi r5, SPACE
	stbio r5, 786(r3)
	movi r5, CHAR_P
	stbio r5, 787(r3)
	movi r5, CHAR_a
	stbio r5, 788(r3)
	movi r5, CHAR_t
	stbio r5, 789(r3)
	movi r5, CHAR_t
	stbio r5, 790(r3)
	movi r5, CHAR_e
	stbio r5, 791(r3)
	movi r5, CHAR_r
	stbio r5, 792(r3)
	movi r5, CHAR_n
	stbio r5, 793(r3)
	movi r5, COLON
	stbio r5, 794(r3)
	
	br DRAW_FIRST_CHOICE

DRAW_FIRST_CHOICE: 			# "1.  D - D - D - D - "
	
	movia r3, ADDR_CHAR	
	movi r5, NUM_1
	stbio r5, 1294(r3)
	movi r5, DOT
	stbio r5, 1295(r3)
	movi r5, SPACE
	stbio r5, 1296(r3)
	movi r5, SPACE
	stbio r5, 1297(r3)
	
	movi r5, CHAR_D
	stbio r5, 1298(r3)
	movi r5, SPACE
	stbio r5, 1299(r3)
	movi r5, DASH
	stbio r5, 1300(r3)
	movi r5, SPACE
	stbio r5, 1301(r3)
	
	movi r5, CHAR_D
	stbio r5, 1302(r3)
	movi r5, SPACE
	stbio r5, 1303(r3)
	movi r5, DASH
	stbio r5, 1304(r3)
	movi r5, SPACE
	stbio r5, 1305(r3)
	
	movi r5, CHAR_D
	stbio r5, 1306(r3)
	movi r5, SPACE
	stbio r5, 1307(r3)
	movi r5, DASH
	stbio r5, 1308(r3)
	movi r5, SPACE
	stbio r5, 1309(r3)
	
	movi r5, CHAR_D
	stbio r5, 1310(r3)
	movi r5, SPACE
	stbio r5, 1311(r3)
	movi r5, DASH
	stbio r5, 1312(r3)
	movi r5, SPACE
	stbio r5, 1313(r3)
	
	br DRAW_SECOND_CHOICE
	
DRAW_SECOND_CHOICE:	# "2.  D - U - D - U - "
	
	movia r3, ADDR_CHAR
	movi r5, NUM_2
	stbio r5, 1678(r3)
	movi r5, DOT
	stbio r5, 1679(r3)
	movi r5, SPACE
	stbio r5, 1680(r3)
	movi r5, SPACE
	stbio r5, 1681(r3)
	
	movi r5, CHAR_D
	stbio r5, 1682(r3)
	movi r5, SPACE
	stbio r5, 1683(r3)
	movi r5, DASH
	stbio r5, 1684(r3)
	movi r5, SPACE
	stbio r5, 1685(r3)
	
	movi r5, CHAR_U
	stbio r5, 1686(r3)
	movi r5, SPACE
	stbio r5, 1687(r3)
	movi r5, DASH
	stbio r5, 1688(r3)
	movi r5, SPACE
	stbio r5, 1689(r3)
	
	movi r5, CHAR_D
	stbio r5, 1690(r3)
	movi r5, SPACE
	stbio r5, 1691(r3)
	movi r5, DASH
	stbio r5, 1692(r3)
	movi r5, SPACE
	stbio r5, 1693(r3)
	
	movi r5, CHAR_U
	stbio r5, 1694(r3)
	movi r5, SPACE
	stbio r5, 1695(r3)
	movi r5, DASH
	stbio r5, 1696(r3)
	movi r5, SPACE
	stbio r5, 1697(r3)
	
	br DRAW_THIRD_CHOICE
	
DRAW_THIRD_CHOICE:	# "3.  U - U - U - U - "
	
	movia r3, ADDR_CHAR
	movi r5, NUM_3
	stbio r5, 2062(r3)
	movi r5, DOT
	stbio r5, 2063(r3)
	movi r5, SPACE
	stbio r5, 2064(r3)
	movi r5, SPACE
	stbio r5, 2065(r3)
	
	movi r5, CHAR_U
	stbio r5, 2066(r3)
	movi r5, SPACE
	stbio r5, 2067(r3)
	movi r5, DASH
	stbio r5, 2068(r3)
	movi r5, SPACE
	stbio r5, 2069(r3)
	
	movi r5, CHAR_U
	stbio r5, 2070(r3)
	movi r5, SPACE
	stbio r5, 2071(r3)
	movi r5, DASH
	stbio r5, 2072(r3)
	movi r5, SPACE
	stbio r5, 2073(r3)
	
	movi r5, CHAR_U
	stbio r5, 2074(r3)
	movi r5, SPACE
	stbio r5, 2075(r3)
	movi r5, DASH
	stbio r5, 2076(r3)
	movi r5, SPACE
	stbio r5, 2077(r3)
	
	movi r5, CHAR_U
	stbio r5, 2078(r3)
	movi r5, SPACE
	stbio r5, 2079(r3)
	movi r5, DASH
	stbio r5, 2080(r3)
	movi r5, SPACE
	stbio r5, 2081(r3)	
	
	br DRAW_FOURTH_CHOICE
	
	
DRAW_FOURTH_CHOICE:	# "4.  D - D U D - D U "
	
	movia r3, ADDR_CHAR
	movi r5, NUM_4
	stbio r5, 2446(r3)
	movi r5, DOT
	stbio r5, 2447(r3)
	movi r5, SPACE
	stbio r5, 2448(r3)
	movi r5, SPACE
	stbio r5, 2449(r3)
	
	movi r5, CHAR_D
	stbio r5, 2450(r3)
	movi r5, SPACE
	stbio r5, 2451(r3)
	movi r5, DASH
	stbio r5, 2452(r3)
	movi r5, SPACE
	stbio r5, 2453(r3)
	
	movi r5, CHAR_D
	stbio r5, 2454(r3)
	movi r5, SPACE
	stbio r5, 2455(r3)
	movi r5, DASH
	stbio r5, 2456(r3)
	movi r5, SPACE
	stbio r5, 2457(r3)
	
	movi r5, CHAR_D
	stbio r5, 2458(r3)
	movi r5, SPACE
	stbio r5, 2459(r3)
	movi r5, CHAR_U
	stbio r5, 2460(r3)
	movi r5, SPACE
	stbio r5, 2461(r3)
	
	movi r5, CHAR_D
	stbio r5, 2462(r3)
	movi r5, SPACE
	stbio r5, 2463(r3)
	movi r5, CHAR_U
	movi r5, CHAR_U
	stbio r5, 2464(r3)
	movi r5, SPACE
	stbio r5, 2465(r3)	
	
	br DRAW_INDICATOR_CTRL
