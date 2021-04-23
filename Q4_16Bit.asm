; Program for addition, subtraction, multiplication and division of two 16 bit numbers

.8086
.model small
.DATA
 	MSG1 DB 10,13,"Enter the 1st no ( 16-bit ) : $"
 	MSG2 DB 10,13,"Enter the 2nd no ( 16-bit ) : $"
 	MSG3 DB 10,13,"Addition is       : $"
 	MSG4 DB 10,13,"Subtraction is    : $" 
 	MSG5 DB 10,13,"Multiplication is : $"
 	MSG6 DB 10,13,"Division Quotient is  : $"
 	MSG7 DB 10,13,"Division Remainder is : $"
 	A1 DW 0000H
 	A2 DW 0000H
 	
 	
 	RES1 DW 0000H
 	RES2 DW 0000H
 	RES3 DW 0000H
 	RES4 DW 0000H
 	RES5 DW 0000H
 	RES6 DW 0000H

.CODE
    MOV AX,@DATA  ;Initialising Data Segment
    MOV DS,AX

    MOV AH,09H
    LEA DX,MSG1
    INT 21h
    
    CALL INPUT
    MOV A1, BX
    
;-------------------------------------------------;

    MOV AH,09H
    LEA DX,MSG2
    INT 21H

    CALL INPUT
    MOV A2, BX
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG3
    INT 21H
  
    CALL ADDITION
    CALL DISP
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG4
    INT 21H
  
    CALL SUBTRACTION
    CALL DISP

;-------------------------------------------------;

    MOV AH,09H
    LEA DX,MSG5
    INT 21H
  
    CALL MULTIPLICATION
    CALL DISP
    MOV DX, RES4
    CALL DISP
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG6
    INT 21H
    
    CALL DIVISION
    MOV DX, RES5
    CALL DISP
    
    MOV AH,09H
    LEA DX,MSG7
    INT 21H
    
    MOV DX, RES6
    CALL DISP

    MOV AH,4CH
    INT 21H

;-------------------------------------------------;
;For taking 16 bits input

    INPUT  PROC
	MOV CH,04H
     	MOV CL,04H
     	MOV BX,0000H
      M3: 
	SHL BX, CL
     	MOV AH,01H
     	INT 21H
     	CMP AL,41H
     	JB M4
     	SUB AL,07H
      M4:
	SUB AL,30H
	    MOV AH, 00H
     	ADD BX, AX
     	DEC CH
     	JNZ M3
     	ret
    INPUT  ENDP

;--------------------------------------------------;

    ADDITION PROC
    		 MOV DX, A1
      		 MOV AX, A2
      		 ADD DX, AX 
    		 MOV RES1, DX
    		 ret
    ADDITION ENDP

;---------------------------------------------------;

    SUBTRACTION PROC
    		    MOV DX, A1
    		    MOV AX, A2
    		    SUB DX, AX
    		    MOV RES2, DX
    		    ret
    SUBTRACTION ENDP
    
;---------------------------------------------------;
    
    MULTIPLICATION PROC
    		       MOV AX, A1
    		       MOV DX, A2
      		       MUL DX
      		       MOV RES3, DX
      		       MOV RES4, AX
    		       ret
    MULTIPLICATION ENDP
    
;---------------------------------------------------;
    
    DIVISION PROC
    		 MOV DX, 0000H
    		 MOV AX, A1
      		 MOV BX, A2
      		 DIV BX
    		 MOV RES5, AX
    		 MOV RES6, DX
    		 ret
    DIVISION ENDP
    
;---------------------------------------------------;
	
	DISP PROC
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
	DISP ENDP
END

