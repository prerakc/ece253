/* Part 5 */
/* Prerak Chaudhari*/

.data

TEST_NUM:
	.word 0b00010001000000000000001100110000
    .word 0b11110001000000011111001100110010
    .word 0b11110001000000111111001100110010
    .word 0b01110001000001111111001100110010
    .word 0b00110001000011111111001100110010
    .word 0b11110000001111111110000000001111
    .word 0b11110000001111111111000000001111
    .word 0b11110000000000000001000100000000
    .word 0b11110000000000000001111000000000
    .word 0b11111111111111111111111111111110
    .word -1
    
.text
.global start

start:
	LDR SP, =0x3FFFFFE8
	LDR R4, =TEST_NUM // load address into R4
	MOV R8, #0 // track greatest number of 1's
    MOV R9, #0 // track greatest number of leading 0's
    MOV R10, #0 // track greatest number of trailing 0's
    
LOOP_1:
	LDR R3, [R4], #4 // R3 gets next word, R4 incremented by 4
	CMP R3, #-1 // done with whole list?
	BEQ END
    MOV R5, #0 // reset 1's counter
    MOV R6, #0 // reset leading 0's counter
    MOV R7, #0  // reset trailing 0's counter
    MOV R0, R3
    MOV R1, R3
    BL ONES // number of 1's subroutine
    BL LEADING // number of leading 0's subroutine
    BL TRAILING // number of trailing 0's subroutine
    CMP R8, R5 // number of 1's result in R5
    MOVLT R8, R5 // new best result
    CMP R9, R6 // leading 0's result in R6
    MOVLT R9, R6 // new best result
    CMP R10, R7 // trailing 0's result in R7
    MOVLT R10, R7 // new best result
    B LOOP_1
END:
	B END

// subroutine to find the number of 1s in a word of data
// result returned in R5
ONES:

LOOP_2:
	CMP R0, #0 // loop until the data contains no more 1’s
    BEQ E_ONES
	SUB R2, R0, #1 // subtract 1
	AND R0, R0, R2 // perform n&(n-1)
	ADD R5, #1 // count the counter so far
	B LOOP_2

E_ONES:
	mov PC, LR //return

// subroutine to find the number of leading 0s in a word of data
// result returned in R6
LEADING:

LOOP_3:
	CLZ R6, R3
	mov PC, LR //return
    
// subroutine to find the number of trailing 0s in a word of data
// result returned in R7
TRAILING:

LOOP_4:
    AND R11, R1, #1
	CMP R11, #0 // loop until first 1 is found
    BNE E_TRAILING
    LSR R1, R1, #1
	ADD R7, #1 // increase trailing zero counter by 1
	B LOOP_4

E_TRAILING:
	mov PC, LR //return
.end