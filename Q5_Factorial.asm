;Program for factorial of number

.8086
.model small
.DATA
 	MSG1 DB 10,13,"Enter the number ( 8 bit ) : $" 
 	MSG2 DB 10,13,"Factorial of number is : $"
 	A1 DB 00H
 	RES DW 0000H

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
    
    CALL PERFORM
    CALL DISP

HALT: MOV AH,4CH
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
            MOV CH, 00H
    		MOV CL, A1
      		MOV AX,0001H
       	    
       	    FACT: MUL CX
       	          LOOP FACT
       	          
       	    MOV DX, AX
    		MOV RES, AX
    		ret
    PERFORM ENDP

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