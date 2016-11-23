;Class: CSE 313 Machine Organization Lab
;Term: Fall 2016
;Name(s): Steven Tang and Andrew Hedy
;Group #9
;Lab#7: Computing Days of the week
;Description: 

		.ORIG x3000
first	LDI R3, M 			;Month is now in R3
		LDI R4, Y           ;Y is now in R4
		ADD R0, R0, R3		;r3 goes in r0
		JSR MONTH
		ST R0, sREG		
		
second	AND R0, R0, #0
		ADD R0, R0, R4		
		JSR SEP				
		ST R1, sREG1			
		ST R0, sREG2	
		
	
third	LD R0, sREG			
		ADD R0, R0, #1			
		AND R1, R1, #0
		ADD R1, R1, #13
		AND R2, R2, #0			
		JSR MULT			
		
fourth	AND R0, R0, #0
		AND R1, R1, #0
		ADD R0, R0, R2  		
		ADD R1, R1, #5
		NOT R1, R1
		ADD R1, R1, #1
		AND R2, R2, #0			
		JSR DIV			
		
        
fifth	LDI R0, K				;R0 now has k
		ADD R6, R0, R2			
		
       
sixth  	LD R0, sREG2			
		ADD R6, R6, R0			
		
        ;calculate D/4
seven	AND R1, R1, #0
		ADD R1, R1, #4
		AND R2, R2, #0
		NOT R1, R1
		ADD R1, R1, #1
		JSR DIV			
		
eight	ADD R6, R6, R2
		LD R0, sREG1			
		AND R1, R1, #0
		ADD R1, R1, #2
		AND R2, R2, #0
		JSR MULT
		NOT R2, R2
		ADD R2, R2, #1
		ADD R6, R6, R2			

nine	
		AND R1, R1, #0
		ADD R1, R1, #4
		NOT R1, R1
		ADD R1, R1, #1
		AND R2, R2, #0
		JSR DIV			   
		
		ADD R6, R6, R2			
		AND R0, R0, #0
		AND R1, R1, #0
		AND R2, R2, #0
		ADD R0, R0, R6
		ADD R1, R1, #7
		NOT R1, R1
		ADD R1, R1, #1
		JSR DIV			
		ADD R3, R0, #0
		STI R3, FINAL
		
		LEA R0, DAYS
xLOOP	ADD R3, R3, #0
		BRz PRINT
		ADD R0, R0, #10
		ADD R3, R3, #-1
		BR xLOOP
PRINT PUTS
		HALT
		
MONTH	ADD R0, R0, #-2
		BRnz	MONTH1			
		BRp	MONTH2			
MONTH1	ADD R0, R0, #14			
		ADD R4, R4, #-1
		RET
MONTH2		ADD R0, R0, #2			
		RET
SEP		AND R3, R3, x0		
		ADD R3, R3, #15
		ADD R3, R3, #15
		ADD R3, R3, #15
		ADD R3, R3, #15
		ADD R3, R3, #15
		ADD R3, R3, #15
		ADD R3, R3, #10
		
		NOT R3, R3
		ADD R3, R3, #1
		AND R2, R2, #0			
		AND R1, R1, #0			
		BR SEPLOOP
SEPLOOP		ADD R0, R0, R3			
		BRnz SEPEND
		ADD R1, R1, #1		
		BR SEPLOOP
SEPEND		NOT R3, R3
		ADD R3, R3, #1
		ADD R0, R0, R3			
		ADD R2, R0, R3			
		RET
MULT		ADD R2, R2, R0
		ADD R1, R1, #-1
		BRz RETURN
		BR	MULT
DIV		ADD R0, R0, R1
		ADD R2, R2, #1
		;COMPARE X AND Y
		AND R3, R3, #0
		ADD R3, R0, R1
		BRn RETURN
		BR DIV
		
RETURN 	RET
K	    .FILL x31F0
M	    .FILL x31F1
Y	    .FILL x31F2
FINAL	.FILL x31F3
sREG	.FILL x0			
sREG1	.FILL x0			
sREG2 	.FILL x0			
;Code from previous lab
DAYS	.STRINGZ "Saturday "
		.STRINGZ "Sunday   "
		.STRINGZ "Monday   "
		.STRINGZ "Tuesday  "
		.STRINGZ "Wednesday"
		.STRINGZ "Thursday "
		.STRINGZ "Friday   "
				
.END