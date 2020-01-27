.include "address_map_arm.s"
/* 
 * This program demonstrates the use of interrupts using the KEY and timer ports. It
 * 	1. displays a sweeping red light on LEDR, which moves left and right
 * 	2. stops/starts the sweeping motion if KEY3 is pressed
 * Both the timer and KEYs are handled via interrupts
*/
.text
.global	_start
_start:
//... initialize the IRQ stack pointer ...
MOV     R0, #0b10010            //switch to IRQ mode by assigning 10010 to the last 5 bits of CPSR)
MSR     CPSR, R0				//move into IRQ (interrupt)mode
LDR     SP, =0xFFFFFFFC          // Define IRQ Stack Pointer Location


//... initialize the SVC stack pointer ...
MOV     R0, #0b10011            //switch to SVC Mode
MSR     CPSR, R0				//move into Supervisor mode
LDR     SP, =0x3FFFFFFC          //define SVC Stack Pointer Location


BL	CONFIG_GIC				// configure the ARM generic interrupt controller
BL	CONFIG_PRIV_TIMER		// configure the MPCore private timer
BL	CONFIG_KEYS				// configure the pushbutton KEYs
		
//... enable ARM processor interrupts ...
MSR     CPSR, #0b00010011       

LDR		R6, =0xFF200000 		// red LED base address

MAIN:
LDR		R4, LEDR_PATTERN		// LEDR pattern; modified by timer ISR
STR 	R4, [R6] 				// write to red LEDs
B 		MAIN

/* Configure the MPCore private timer to create interrupts every 1/10 second */
CONFIG_PRIV_TIMER:
LDR		R0, =0xFFFEC600 		// Timer base address
// ... code not shown
LDR     R1, =50000000            // frequency. Clock is 200 MHz -> 0.25 s = 50000000
STR     R1, [R0]                // store frequency in load part of timer
LDR     R2, =0b111
STR     R2, [R0, #8]            // Interrupt, Enable (Start Timer), Auto-Reload
MOV 	PC, LR 					// return


/* Configure the KEYS to generate an interrupt */
CONFIG_KEYS:
LDR		R0, =0xFF200050 		// KEYs base address
LDR     R3, =0b1000             //store key3=1 (since this is the only key we want to trigger an interrupt)
STR     R3, [R0, #8]            // store 1 into the interrupt mask register, which allows an interrupt to be triggered anytime KEY3 changes
MOV	PC, LR 					// return

.global	LEDR_DIRECTION
LEDR_DIRECTION:
.word 	0							// 0 means means moving to centre; 1 means moving to outside

.global	LEDR_PATTERN
LEDR_PATTERN:
.word 	0x201	// 1000000001
