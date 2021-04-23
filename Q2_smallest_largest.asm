;Program to find the smallest and largest number from a given list

.8086
.model small
.DATA
    MSG1 DB 0DH, 0AH, "Enter Size of List ( 8 bits ) : $"
    MSG2 DB 0DH, 0AH, "Enter the number ( 8 bit ) : $"
    MSG3 DB 0DH, 0AH, "Smallest number is : $"                     
    MSG4 DB 0DH, 0AH, "Largest number is : $"

    SIZE DB 00H
    LIST DB 0FFDUP(00H)
 	LARGE DB 00H
 	SMALL DB 00H

.CODE
    MOV AX,@DATA  ;Initialising Data Segment
    MOV DS,AX

    MOV AH,09H
    LEA DX,MSG1
    INT 21H
    
    CALL INPUT
    MOV SIZE,BL
    
    MOV CH, 00H    
    MOV CL, SIZE
    LEA SI, LIST
    
    MULTI:
        PUSH CX
        MOV AH,09H
        LEA DX,MSG2
        INT 21H
        CALL INPUT
        MOV [SI], BL
        INC SI
        POP CX
        LOOP MULTI
      
;-------------------------------------------------;
        
    CALL MAXMIN
    
    MOV AH,09H
    LEA DX,MSG3
    INT 21H
    
    MOV DL, SMALL
    CALL DISP
    
    MOV AH,09H
    LEA DX,MSG4
    INT 21H
    
    MOV DL, LARGE
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

    MAXMIN PROC
        LEA BX, LIST
        MOV CH, 00H
        MOV CL, SIZE
        MOV DH, [BX]
        MOV DL, [BX]
        DEC CX
    MM: 
        INC BX
        CMP DL, [BX]
        JC M1
        MOV DL, [BX]
    M1: 
        CMP DH, [BX]
        JNC M2
        MOV DH, [BX]
    M2:
        LOOP MM
        MOV LARGE, DH
        MOV SMALL, DL
        RET
    MAXMIN ENDP

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
        RET
	DISP ENDP
END