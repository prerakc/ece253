/* PSEUDO CODE WRITTEN IN C++
void bubbleSort(int arr[], int n) // int arr[] is the array of numbers, int n is the number of items in array
{ 
   // variables to hold counters
   int i = 0;
   int j = 0;

   bool swapped = False; // boolean to determine if a swapped has occured

   for (i = 0; i < n-1; i++) // while index of current number is less than n - 1
   { 
     swapped = false; // reset swapped to 0

     for (j = 0; j < n-i-1; j++) // while index of adjacent number is less than n - i - 1
     { 
        if (arr[j] > arr[j+1]) // if adjacent number is greater than current number
        { 
           swap(&arr[j], &arr[j+1]); // perform swap
           swapped = true; // boolean set to true to indicate a swap has occured
        } 
     } 
  
     // If no two elements were swapped by inner loop, then break
     if (swapped == false) 
        break; 
   } 
} 
*/

.text
.global _start

List: .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33

_start:
	LDR SP, =0x2000
	LDR R0, =List
	LDR R1, [R0] // n
	MOV R2, #0 // i
	MOV R3, #0 // j
	SUB R4, R1, #1 // n - 1
	MOV R5, #0 // n - i - 1
	MOV R6, #0 // swapped
	MOV R7, #4 // byte offset

	B OUTER	// outer loop

OUTER:
	CMP R2, R4 // if i = n - 1, end
	BEQ END

	MOV R3, #0 // j reset to 0
	MOV R6, #0 // reset swapped to 0
	SUB R5, R1, R2 // calculate n - i - 1
	SUB R5, R5, #1

	BL INNER // inner loop

	CMP R6, #0 // if swap hasnt occured, end
	BEQ END

	ADD R2, R2, #1 // i++
	
	B OUTER

INNER:
	PUSH {LR}
	B INNER_MAIN

INNER_MAIN:
	CMP R3, R5 // if j = n - i - 1
	BEQ INNER_EXIT

	LDR R0, =List // R0 points to memory location

	BL SWAP // check if swap is needed

	ORR R6, R6, R0 // update swapped

	ADD R3, R3, #1 // j++
	
	B INNER_MAIN

INNER_EXIT:
	POP {PC}

SWAP:
	PUSH {LR}

	MUL R8, R3, R7 // calculate offset
	ADD R8, R8, R7
	LDR R9, [R0, R8] // arr[j]
	ADD R8, R8, #4
	LDR R10, [R0, R8] // arr[j+1]

	CMP R9, R10 // compare arr[j] with arr[j+1]
	BGT PERFORM_SWAP // arr[j] > arr[j+1] so perform swap
	BLE NO_SWAP // arr[j] <= arr[j+1] so no swap needed

PERFORM_SWAP:
	// swap arr[j] and arr[j+1]
	STR R9, [R0, R8]
	SUB R8, R8, #4
	STR R10, [R0, R8]

	MOV R0, #1

	POP {PC}

NO_SWAP:
	MOV R0, #0

	POP {PC}

END:
	B END

.end