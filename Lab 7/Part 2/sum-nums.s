TEST_NUM:	.word	1,2,0,3,5,-5,0xA,-1,8 // numbers to add

.text
.global _start

_start:	MOV R8, #0 // positive number counter
		MOV R6, #0 // index counter
		MOV R7, #0 // sum
        LDR R1, =TEST_NUM // point to memory location of numbers
        MOV R2, #4 // byte offset 
        B LOOP // go to loop
            
LOOP: MUL R3, R2, R6 // determine offset needed to reach next number
	  LDR R4, [R1, R3] // retrieve next number 
      CMP R4, #0 // compare to 0 (R4 - 0)
      BGT NOT_NEG // if number is non-negative, proceed to sum and counter incrementation
      BLE CHECK // else, check if number if -1
    
NOT_NEG: ADD R7, R7, R4 // add number to sum
		 ADD R8, R8, #1 // increase positive number counter by 1
         ADD R6, R6, #1 // increase index counter by 1
    	 B LOOP // go back to loop
         
CHECK: CMP R4, #-1 // compare to -1 (R4 - (-1))
	   BEQ END // if number is -1, end program
       ADD R6, R6, #1 // increase index counter by 1
       B LOOP // go back to loop
    
END: B END
	 .end