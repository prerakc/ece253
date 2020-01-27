/* Part 4 */
/* Prerak Chaudhari*/

.data

TEST_NUM:
	.word 0x11000332 // 10001000000000000001100110010 (2)
    .word 0x1101F332 // 10001000000011111001100110010 (5)
    .word 0x1103F332 // 10001000000111111001100110010 (6)
    .word 0x1107F332 // 10001000001111111001100110010 (7)
    .word 0x110FF332 // 10001000011111111001100110010 (8)
    .word 0x103fe00f // 10000001111111110000000001111 (9)
    .word 0x103ff00f // 10000001111111111000000001111 (10)
    .word 0x10001100 // 10000000000000001000100000000 (1)
    .word 0x10001e00 // 10000000000000001111000000000 (4)
    .word 0x10fff00f // 10000111111111111000000001111 (12)
    .word -1
    
.text
.global start

start:
	LDR R4, =TEST_NUM // load address into R4
	MOV R5, #0 // track longest string of 1s
    
LOOP_1:
	LDR R1, [R4], #4 // R1 gets next word, R4 incremented by 4
    MOV R0, #0 // reset per word counter
	CMP R1, #-1 // done with whole list?
	BEQ END
    BL ONES // parameter passed in R1
    CMP R5, R0 // result in R0
    MOVLT R5, R0 // new best result
    B LOOP_1
END:
	B END

// subroutine to find longest string of 1's in R1
// result returned in R0
ONES:

LOOP_2: // code to SHIFT & AND
	CMP R1, #0 // loop until the data contains no more 1’s
    BEQ E_ONES
	LSR R2, R1, #1 // perform SHIFT, followed by AND
	AND R1, R1, R2
	ADD R0, #1 // count the string lengths so far
	B LOOP_2

E_ONES:
	mov PC, LR //return
    
.end