;Program for finding whether given number is Even or Odd

.8086
.model small
.DATA
 	MSG1 DB 10,13,"Enter the number ( 8 bit ) : $" 
 	MSG2 DB 10,13,"Given number is Even $"
 	MSG3 DB 10,13,"Given number is Odd $"
 	
 	A1 DB 00H
 	RES1 DB 00H
 	RES2 DB 00H

.CODE
    MOV AX,@DATA  ;Initialising Data Segment
    MOV DS,AX

    MOV AH,09H
    LEA DX,MSG1
    INT 21h
    
    CALL INPUT
    MOV A1,BL
    CALL PERFORM
    
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

    PERFORM PROC
    		MOV AL, A1
     	    MOV AH, 00H
     	    MOV DL, 02H
    		DIV DL
    		MOV DL, AH
    		MOV DH, 01H
            CMP DL, DH
            JC EVEN
            JNC ODD

        EVEN: MOV AH,09H
            LEA DX,MSG2
            INT 21H
            RET
      
        ODD:  MOV AH,09H
            LEA DX,MSG3
            INT 21H
            RET
    PERFORM ENDP