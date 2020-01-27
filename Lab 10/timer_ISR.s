.include "address_map_arm.s"
.extern	LEDR_DIRECTION
.extern	LEDR_PATTERN

/*****************************************************************************
 * MPCORE Private Timer - Interrupt Service Routine                                
 *                                                                          
 * Shifts the pattern being displayed on the LEDR
 * 
******************************************************************************/
.global PRIV_TIMER_ISR
PRIV_TIMER_ISR:	
LDR		R0, =MPCORE_PRIV_TIMER	// base address of timer
MOV		R1, #1
STR		R1, [R0, #0xC]				// write 1 to F bit to reset it
															// and clear the interrupt

/* Move the two LEDS to the centre or away from the centre to the outside. */
SWEEP:		
LDR		R0, =LEDR_DIRECTION	// put shifting direction into R2
LDR		R2, [R0]
LDR		R1, =LEDR_PATTERN		// put LEDR pattern into R3
LDR		R3, [R1]

//				...
CMP R2, #0 //check if shifting to centre
BEQ TOCENTRE
B TOOUTSIDE

                
TOCENTRE:		
//...
//...
LDR R7, =0b1111100000
LDR R8, =0b0000011111
lDR R9, =0b0000110000
AND R10, R7, R3 //extract left 5 bits
AND R11, R8, R3 //extract right 5 bits
LSR R10, R10, #1 //shift left bits to right
LSL R11, R11, #1 //shift right bits to left
ORR R3, R10, R11 //combine shifted values and store back into R1

CMP R3, R9 //check if reached centre
BEQ C_O //if so then switch sweep direction
B DONE_SWEEP


C_O:
MOV		R2, #1					// change direction to outside
B DONE_SWEEP

TOOUTSIDE:		
//...
//...
LDR R7, =0b1111100000
LDR R8, =0b0000011111
LDR R9, =0b1000000001
AND R10, R7, R3 //extract left 5 bits
AND R11, R8, R3 //extract right 5 bits
LSL R10, R10, #1 //shift left bits to right
LSR R11, R11, #1 //shift right bits to left
ORR R3, R10, R11 //combine shifted values and store back into R1

CMP R3,R9 //check if reached outside
BEQ O_C
B DONE_SWEEP

O_C:
MOV		R2, #0					// change direction to centre
B			DONE_SWEEP

DONE_SWEEP:
STR		R2, [R0]					// put shifting direction back into memory
STR		R3, [R1]					// put LEDR pattern back onto stack

END_TIMER_ISR:
MOV		PC, LR
