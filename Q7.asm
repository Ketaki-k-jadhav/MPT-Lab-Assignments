;Program for calculating the expressions 1.(a+b)*(c+d) and 2.(a*b)+(c*d)

.8086
.model small
.DATA
 	MSG1 DB 10,13,"Enter the 1st no : $"
 	MSG2 DB 10,13,"Enter the 2nd no : $"
 	MSG3 DB 10,13,"Enter the 3rd no : $"
 	MSG4 DB 10,13,"Enter the 4th no : $" 
 	MSG5 DB 10,13,"Result of (a+b)*(c+d) : $"
 	MSG6 DB 10,13,"Result of (a*b)+(c*d) : $"
 	
 	A1 DB 00H
 	A2 DB 00H
 	A3 DB 00H
 	A4 DB 00H
 	RES1 DW 0000H
 	RES2 DW 0000H

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
    INT 21h

    CALL INPUT
    MOV A3,BL
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG4
    INT 21h

    CALL INPUT
    MOV A4,BL

;-------------------------------------------------;

    MOV AH,09H
    LEA DX,MSG5
    INT 21H
  
    CALL PERFORM1
    CALL DISP
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG6
    INT 21H
    
    CALL PERFORM2
    CALL DISP

HALT:MOV AH,4CH
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
;Performs (a+b)*(c+d)

    PERFORM1 PROC
    		 MOV DL, A1
      		 MOV DH, A2
       		 MOV AL, A3
       	     MOV AH, A4
    		 ADD DL, DH
    		 ADD AL, AH
    		 MUL DL
    		 MOV DX, AX 
    		 MOV RES1, AX
    		 ret
    PERFORM1 ENDP

;---------------------------------------------------;
;Performs (a*b)+(c*d)

    PERFORM2 PROC
    		 MOV AL, A1
      		 MOV AH, A2
      		 MUL AH
      		 MOV DX, AX
       		 MOV AL, A3
       	     MOV AH, A4
    		 MUL AH
    		 ADD DX, AX 
    		 MOV RES2, DX
    		 ret
    PERFORM2 ENDP                                    
    
;---------------------------------------------------;
;Procedure to Display   

	DISP PROC
		MOV CL,04H
		MOV CH,04H
		MOV BX, DX
	     R1: 
		ROL BX,CL
    		MOV DX,BX
    		AND DX,000FH
    		CMP DX,000AH
    		JB R2
    		ADD DX,0007H
	     R2: 
		ADD DX,0030H
    		MOV AH,02H
    		INT 21H
    		DEC CH
    		JNZ R1
    		ret
	DISP ENDP
END

