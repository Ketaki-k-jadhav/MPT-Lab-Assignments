; Program for addition and subtraction of two 32 bit numbers


.8086
.model small
.DATA
 	MSG1 DB 10,13,"Enter the 1st no ( 32-bit ) : $"
 	MSG2 DB 10,13,"Enter the 2nd no ( 32-bit ) : $"
 	MSG3 DB 10,13,"Addition is    : $"
 	MSG4 DB 10,13,"Subtraction is : $"
 	
 	
 	A1 DW 0000H
 	A2 DW 0000H
 	A3 DW 0000H
 	A4 DW 0000H
 	
 	RES1 DW 0000H
 	RES2 DW 0000H
 	RES3 DW 0000H
 	RES4 DW 0000H

.CODE
    MOV AX,@DATA  ;Initialising Data Segment
    MOV DS,AX

    MOV AH,09H
    LEA DX,MSG1
    INT 21h
    
    CALL INPUT
    MOV A1, BX
    CALL INPUT
    MOV A2, BX
    
;-------------------------------------------------;

    MOV AH,09H
    LEA DX,MSG2
    INT 21H

    CALL INPUT
    MOV A3, BX
    CALL INPUT
    MOV A4, BX
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG3
    INT 21H
  
    CALL ADDITION
    MOV DX, RES1
    CALL DISP
    MOV DX, RES2
    CALL DISP
    
;-------------------------------------------------;
    
    MOV AH,09H
    LEA DX,MSG4
    INT 21H
  
    CALL SUBTRACTION
    MOV DX, RES3
    CALL DISP
    MOV DX, RES4
    CALL DISP


HALT: MOV AH,4CH
    INT 21H

;-------------------------------------------------;
;For taking 32 bits input

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
    		 MOV AX, A1
      		 MOV BX, A2
      		 MOV CX, A3
      		 MOV DX, A4
      		 ADD BX, DX
      		 ADC AX, CX
      		  
    		 MOV RES1, AX
    		 MOV RES2, BX
    		 ret
    ADDITION ENDP

;---------------------------------------------------;

    SUBTRACTION PROC
    		    MOV AX, A1
      		    MOV BX, A2
      		    MOV CX, A3
      		    MOV DX, A4
      		    SUB BX, DX
      		    SBB AX, CX
      		  
    		    MOV RES3, AX
    		    MOV RES4, BX
    		    ret
    SUBTRACTION ENDP
    
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

