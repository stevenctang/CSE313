;Class: CSE 313 Machine Organization Lab
;Term: Fall 2016
;Group #9
;Name(s): Steven Tang and Andrew Hedy
;Lab#7: COMPUTE DAY OF THE WEEK
;Description: 

		.ORIG x3000
STEP1		LDI R3, M 			;LOAD MONTH
		LDI R4, Y
		ADD R0, R0, R3			;R0 <- R3
		JSR MONTH
		ST R0, SAVEREG0			;SAVE m
		
STEP2		AND R0, R0, #0
		ADD R0, R0, R4			;R0 <- R4
		JSR SEP				;SEPARATE
		ST R1, SAVEREG1			;Save ye - C
		ST R0, SAVEREG2			;Save ar - D
		
		;calculate (13 x (m + 1))
STEP3		LD R0, SAVEREG0			;LOAD m
		ADD R0, R0, #1			;M+1
		AND R1, R1, #0
		ADD R1, R1, #13
		AND R2, R2, #0			;R2 IS PRODUCT
		JSR MULT			;R2 <- 13 X (M+1)
		;calculate (13 x m - 1)/5
STEP4		AND R0, R0, #0
		AND R1, R1, #0
		ADD R0, R0, R2  		;R0 <- (13m)
		ADD R1, R1, #5
		NOT R1, R1
		ADD R1, R1, #1
		AND R2, R2, #0			;R2 QUO
		JSR DIVID			; R2 <- (13(M+1))/5
		;calculate (k + (13m-1)/5)
STEP5		LDI R0, K				;LOAD K INTO R0
		ADD R6, R0, R2			;R6 <- K + (13(M+1))/5
		;calculate (k + (13m-1)/5 + D)
STEP6   	LD R0, SAVEREG2				;R0 <- D
		ADD R6, R6, R0			;R6 <- K+(13(M+1))/5 + D
		;calculate D/4
STEP7		AND R1, R1, #0
		ADD R1, R1, #4
		AND R2, R2, #0
		NOT R1, R1
		ADD R1, R1, #1
		JSR DIVID			;R2 <- D/4
		;calculate K+(13-1)/5+D+D/4-2C
STEP8		ADD R6, R6, R2			;R6 <- K+(13(M+1))/5+D+D/4
		;calculate -2C
		LD R0, SAVEREG1			;LOAD C INTO R0
		AND R1, R1, #0
		ADD R1, R1, #2
		AND R2, R2, #0
		JSR MULT
		NOT R2, R2
		ADD R2, R2, #1
		;add -2C
		ADD R6, R6, R2			;R6 <- R6 -2C
STEP9		;calculate C/4
		AND R1, R1, #0
		ADD R1, R1, #4
		NOT R1, R1
		ADD R1, R1, #1
		AND R2, R2, #0
		JSR DIVID			;R2 <- C/4
		;calculate K+(13-1)/5+D+D/4+C/4-2C
		ADD R6, R6, R2			;R6 <- R6 + C/4 = F
		;calculate F%7
		AND R0, R0, #0
		AND R1, R1, #0
		AND R2, R2, #0
		ADD R0, R0, R6
		ADD R1, R1, #7
		NOT R1, R1
		ADD R1, R1, #1
		JSR DIVID			;-R3 <- F%7
		ADD R3, R0, #0
		STI R3, FINAL
		;DISPLAY
		LEA R0, DAYS
DISLOOP		ADD R3, R3, #0
		BRz DISPLAY
		ADD R0, R0, #10
		ADD R3, R3, #-1
		BR DISLOOP
DISPLAY 	PUTS
		HALT
		
MONTH		ADD R0, R0, #-2
		BRnz	MONTH1			;if m<=2
		BRp	MONTH2			;if m>2
MONTH1		ADD R0, R0, #14			;if m=1 -> m=11
		ADD R4, R4, #-1
		RET
MONTH2		ADD R0, R0, #2			;if m=3~12 -> m=1~10
		RET
SEP		AND R3, R3, x0			;R3 - ADDER
		ADD R3, R3, #15
		ADD R3, R3, #15
		ADD R3, R3, #15
		ADD R3, R3, #15
		ADD R3, R3, #15
		ADD R3, R3, #15
		ADD R3, R3, #10
		
		NOT R3, R3
		ADD R3, R3, #1
		AND R2, R2, #0			;RETURN - remainder
		AND R1, R1, #0			;return - quo
		BR SEPLOOP
SEPLOOP		ADD R0, R0, R3			;R1 <- R0 - 100
		BRnz SEPEND
		ADD R1, R1, #1			;quo + 1
		BR SEPLOOP
SEPEND		NOT R3, R3
		ADD R3, R3, #1
		ADD R0, R0, R3			;R0 <- REMAINDER
		ADD R2, R0, R3			;R2 <- R0 + R3 = QUO
		RET
MULT		ADD R2, R2, R0
		ADD R1, R1, #-1
		BRz RETURN
		BR	MULT
DIVID		ADD R0, R0, R1
		ADD R2, R2, #1
		;COMPARE X AND Y
		AND R3, R3, #0
		ADD R3, R0, R1
		BRn RETURN
		BR DIVID
		
RETURN 	RET
K	.FILL x31F0
M	.FILL x31F1
Y	.FILL x31F2
FINAL	.FILL x31F3
SAVEREG0	.FILL x0			;m
SAVEREG1	.FILL x0			;ye - C
SAVEREG2 	.FILL x0			;ar - D
DAYS		.STRINGZ "Saturday "
		.STRINGZ "Sunday   "
		.STRINGZ "Monday   "
		.STRINGZ "Tuesday  "
		.STRINGZ "Wednesday"
		.STRINGZ "Thursday "
		.STRINGZ "Friday   "
		
			
.END