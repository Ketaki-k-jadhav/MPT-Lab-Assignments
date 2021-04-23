;Program To Perform Block Exchange

.8086
.MODEL SMALL
.STACK

.DATA
SIZE EQU 5
ARR DB 01H, 02H, 03H, 04H, 05H
ARR1 DB 06H, 07H, 08H, 09H, 0AH
MSG1 DB 0DH, 0AH, "ARR1:", 0DH, 0AH, "$"
MSG2 DB 0DH, 0AH, "ARR2:", 0DH, 0AH, "$"

.CODE

MOV AX, @DATA
MOV DS, AX
MOV ES, AX

LEA BX, ARR
LEA SI, ARR1
MOV CL, SIZE
	
LOOP1:	MOV AL, [BX]
        MOV AH, [SI]
	    MOV [BX], AH
	    MOV [SI], AL
	    INC BX
    	INC SI
	    DEC CL
    	JNZ LOOP1

LEA DX, MSG1
CALL PRINT
LEA SI, ARR
MOV CX, SIZE

ABOVE: PUSH CX
LODSB
CALL OUTPUT
MOV DL, ' '
MOV AH, 02H
INT 21H
POP CX
LOOP ABOVE

LEA DX, MSG2
CALL PRINT
LEA SI, ARR1
MOV CX, SIZE

ABOVE1: PUSH CX
LODSB
CALL OUTPUT
MOV DL, ' '
MOV AH, 02H
INT 21H
POP CX
LOOP ABOVE1

MOV AX, 4C00H
INT 21H

OUTPUT PROC
    
    MOV BX, 02H ; Count of total number of chars in accumulator
    
    MOV CL, 04H ; Rotate left by this amount
    AGAIN: ROL AL, CL ; After rotating left by 4 content of accumulator is CF34
    PUSH AX
    AND AL, 0FH ; AX will become 0004
    CMP AL, 0AH ; Compare AX with 10
    JC NUMBER2
    ADD AL, 37H ; Add 37H if it is between A-F
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    JMP DOWN
    
    NUMBER2: ADD AL, 30H
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    DOWN: POP AX
    DEC BX
    JNZ AGAIN
    RET

OUTPUT ENDP

PRINT PROC
    
    MOV AH, 09H
    INT 21H
    RET
    
PRINT ENDP

END
