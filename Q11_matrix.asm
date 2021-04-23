;Program for matrix addition and subtraction

.MODEL SMALL
.STACK
.DATA
    M1   DB 21H, 22H, 23H, 24H, 25H, 26H, 27H, 28H, 29H
    M2   DB 11H, 12H, 13H, 14H, 15H, 16H, 17H, 18H, 19H
    ELEM EQU 09H
    ROW  EQU 03H
    ADDM DB 9 DUP (0)
    SUBM DB 9 DUP (0)
    MULM DB 9 DUP (0)

    MSG1 DB 10,13,"$"
    MSG2 DB 10,13,"Addition is       : $"
 	MSG3 DB 10,13,"Subtraction is    : $" 
 	

.CODE
    MOV AX, @DATA
    MOV DS, AX
    MOV SS, AX
    
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H

    MOV CX, ELEM
    LEA SI, M1
    LEA DI, M2
    LEA BX, ADDM
    ADDLOOP:
        MOV AL, [SI]
        ADD AL, [DI]
        MOV [BX], AL
        INC SI
        INC DI
        INC BX
        LOOP ADDLOOP
        
    LEA SI, ADDM
    CALL MATRIX
    
;---------------------------------------------------;    
    
    MOV AH, 09H
    LEA DX, MSG3
    INT 21H
        
    MOV CX, ELEM
    LEA SI, M1
    LEA DI, M2
    LEA BX, SUBM
    SUBLOOP:
        MOV AL, [SI]
        SUB AL, [DI]
        MOV [BX], AL
        INC SI
        INC DI
        INC BX
        LOOP SUBLOOP
        
    LEA SI, SUBM
    CALL MATRIX
        

       
    HLT


;---------------------------------------------------;
;Procedure to Display Matrix
    MATRIX PROC
        MOV DH, 09H
     
     J1:MOV DL, [SI]
        CALL DISP
        INC SI
        
        MOV DL,20H
    	MOV AH,02H
    	INT 21H
        
        DEC DH 
        JNZ J1
        
        ret
    MATRIX ENDP

;---------------------------------------------------;
;Procedure to Display   

	DISP PROC
	    MOV CL, 04H
		MOV CH, 02H
		MOV BL, DL
	    R1: ROL BL, CL
    		MOV DL,BL
    		AND DL,0FH
    		CMP DL,0AH
    		JB R2
    		ADD DL,07H
	    R2: ADD DL,30H
    		MOV AH,02H
    		INT 21H
    		
    		DEC CH
    		JNZ R1
    		ret
	DISP ENDP

;---------------------------------------------------;  
