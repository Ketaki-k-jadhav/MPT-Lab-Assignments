; Program for finding 1's 2's complement of a number

.8086
.model small
.DATA
 	MSG1 DB 10,13,"Enter the number ( 8 bit ) : $" 
 	MSG2 DB 10,13,"1's compliment of number : $"
 	MSG3 DB 10,13,"2's compliment of number : $"
 	
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
    
;-------------------------------------------------;

    MOV AH,09H
    LEA DX,MSG2
    INT 21H
  
    CALL PERFORM1
    CALL DISP
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG3
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
;Performs 1's Complement

    PERFORM1 PROC
    		 MOV DL, A1
      		 NOT DL
    		 MOV RES1, DL
    		 ret
    PERFORM1 ENDP

;---------------------------------------------------;
;Performs 2's Complement

    PERFORM2 PROC
    		 MOV DL, A1
      		 NOT DL
       		 ADD DL, 01H
    		 MOV RES1, DL
    		 ret
    PERFORM2 ENDP                                    
    
;---------------------------------------------------;
;Procedure to Display   

	DISP PROC
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
	DISP ENDP
END

