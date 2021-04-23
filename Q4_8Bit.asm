; Program for addition, subtraction, multiplication and division of two 8 bit numbers
                                                                                   
.8086
.model small
.DATA
 	MSG1 DB 10,13,"Enter the 1st no ( 8-bit ) : $"
 	MSG2 DB 10,13,"Enter the 2nd no ( 8-bit ) : $"
 	MSG3 DB 10,13,"Addition is       : $"
 	MSG4 DB 10,13,"Subtraction is    : $" 
 	MSG5 DB 10,13,"Multiplication is : $"
 	MSG6 DB 10,13,"Division Quotient is  : $"
 	MSG7 DB 10,13,"Division Remainder is : $"
 	A1 DB 00H
 	A2 DB 00H
 	
 	
 	RES1 DB 00H
 	RES2 DB 00H
 	RES3 DW 0000H
 	RES4 DB 00H
 	RES5 DB 00H

.CODE
    MOV AX,@DATA  ;Initialising Data Segment
    MOV DS,AX

    MOV AH,09H
    LEA DX,MSG1
    INT 21h
    
    CALL INPUT
    MOV A1,BL
    
;-------------------------------------------------;

    MOV AH,09H
    LEA DX,MSG2
    INT 21H

    CALL INPUT
    MOV A2, BL
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG3
    INT 21H
  
    CALL ADDITION
    CALL DISP1
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG4
    INT 21H
  
    CALL SUBTRACTION
    CALL DISP1

;-------------------------------------------------;

    MOV AH,09H
    LEA DX,MSG5
    INT 21H
  
    CALL MULTIPLICATION
    CALL DISP2
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG6
    INT 21H
    
    CALL DIVISION
    CALL DISP1
    
    MOV AH,09H
    LEA DX,MSG7
    INT 21H
    
    MOV DL, RES5
    CALL DISP1

    MOV AH,4CH
    INT 21H

;-------------------------------------------------;
;For taking 8 bits input

    INPUT  PROC
	MOV CH,02H
     	MOV CL,04H
     	MOV BL,00H
      M3: 
	SHL BL, CL
     	MOV AH,01H
     	INT 21H
     	CMP AL,41H
     	JB M4
     	SUB AL,07H
      M4:
	SUB AL,30H
     	ADD BL,AL
     	DEC CH
     	JNZ M3
     	ret
    INPUT  ENDP

;--------------------------------------------------;

    ADDITION PROC
    		 MOV DL, A1
      		 MOV DH, A2
      		 ADD DL, DH 
    		 MOV RES1, DL
    		 ret
    ADDITION ENDP

;---------------------------------------------------;

    SUBTRACTION PROC
    		    MOV DL, A1
    		    MOV DH, A2
    		    SUB DL, DH
    		    MOV RES2, DL
    		    ret
    SUBTRACTION ENDP
    
;---------------------------------------------------;
    
    MULTIPLICATION PROC
    		       MOV AL, A1
    		       MOV AH, 00H
      	       	   MOV DL, A2
      		       MUL DL
      		       MOV DX, AX 
    		       MOV RES3, DX
    		       ret
    MULTIPLICATION ENDP
    
;---------------------------------------------------;
    
    DIVISION PROC
    		 MOV AL, A1
    		 MOV AH, 00H
      		 MOV DL, A2
      		 DIV DL
    		 MOV RES4, AL
    		 MOV RES5, AH
    		 MOV DX, AX
    		 ret
    DIVISION ENDP
    
;---------------------------------------------------;
;Procedure to Display   

	DISP1 PROC
		MOV CL,04H
		MOV CH,02H
		MOV BL, DL
	     R1: 
		ROL BL,CL
    		MOV DL,BL
    		AND DL,0FH
    		CMP DL,0AH
    		JB R2
    		ADD DL,07H
	     R2: 
		ADD DL,30H
    		MOV AH,02H
    		INT 21H
    		DEC CH
    		JNZ R1
    		ret
	DISP1 ENDP

;---------------------------------------------------;
	
	DISP2 PROC
		MOV CL,04H
		MOV CH,04H
		MOV BX, DX
	     RR1: 
		ROL BX,CL
    		MOV DX,BX
    		AND DX,000FH
    		CMP DX,000AH
    		JB RR2
    		ADD DX,0007H
	     RR2: 
		ADD DX,0030H
    		MOV AH,02H
    		INT 21H
    		DEC CH
    		JNZ RR1
    		ret
	DISP2 ENDP
END

