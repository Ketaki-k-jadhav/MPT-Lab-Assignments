; Arranging a given list in ascending and descending order

.8086
.MODEL SMALL
.STACK

.DATA

MSG2 DB 0DH, 0AH, "Enter 8-bit hex number: $"                     
MSG3 DB 0DH, 0AH, "Enter Size of List: $"
MSG4 DB 0DH, 0AH, "Ascending Order", 0DH, 0AH, "$"
MSG5 DB 0DH, 0AH, "Descending Order", 0DH, 0AH, "$"
SIZE DB ?
LIST DB 0FFDUP(00H)

.CODE

MOV AX, @DATA
MOV DS, AX

LEA DX, MSG3
CALL PRINT
CALL INPUT

LEA SI, SIZE
MOV BYTE PTR[SI], BL
MOV CX, BX

LEA SI, LIST
NEXT_INPUT: LEA DX, MSG2
PUSH CX
CALL PRINT
CALL INPUT
MOV BYTE PTR[SI], BL
INC SI
POP CX
LOOP NEXT_INPUT


; Ascending order

LEA SI, SIZE
MOV DL, BYTE PTR[SI]
CMP DL, 01H
JZ PRINTLIST
MOV DH, 00H
DEC DX ; Number of comparisons = 4

AGAIN2: LEA BX, LIST ; List of numbers present at 2000H
MOV CX, DX

UP: MOV AL, BYTE PTR[BX]
CMP AL, BYTE PTR[BX + 01]
JC DOWN2
XCHG AL, BYTE PTR[BX + 01]
MOV BYTE PTR[BX], AL
DOWN2: INC BX
LOOP UP
DEC DX
JNZ AGAIN2

PRINTLIST: LEA DX, MSG4
CALL PRINT
LEA SI, SIZE
MOV CL, BYTE PTR[SI]
MOV CH, 00H

LEA SI, LIST
NEXT3: MOV AL, BYTE PTR[SI]
PUSH CX
CALL OUTPUT
POP CX
INC SI
MOV DL, ' '
MOV AH, 02H
INT 21H
LOOP NEXT3


; Descending order

LEA SI, SIZE
MOV DL, BYTE PTR[SI]
CMP DL, 01H
JZ PRINTLIST2
MOV DH, 00H
DEC DX ; Number of comparisons = 4

AGAIN3: LEA BX, LIST ; List of numbers present at 2000H
MOV CX, DX

UP1: MOV AL, BYTE PTR[BX]
CMP AL, BYTE PTR[BX + 01]
JNC DOWN3
XCHG AL, BYTE PTR[BX + 01]
MOV BYTE PTR[BX], AL
DOWN3: INC BX
LOOP UP1
DEC DX
JNZ AGAIN3

PRINTLIST2: LEA DX, MSG5
CALL PRINT
LEA SI, SIZE
MOV CL, BYTE PTR[SI]
MOV CH, 00H

LEA SI, LIST
NEXT4: MOV AL, BYTE PTR[SI]
PUSH CX
CALL OUTPUT
POP CX
INC SI
MOV DL, ' '
MOV AH, 02H
INT 21H
LOOP NEXT4



HALT: MOV AX, 4C00H
INT 21H              

;--------------------------------------------------------------------------

INPUT PROC

    MOV BX, 0000H
    MOV CX, 02H
    
    NEXT: MOV AH, 01H
    INT 21H
    
    CMP AL, 40H
    JC NUMBER
    SUB AL, 07H
    NUMBER: SUB AL, 30H
    MOV AH, 00H
    ADD BX, AX
    ROL BX, 04H
    LOOP NEXT
    ROR BX, 04H
    
    RET
   
    
INPUT ENDP  

;----------------------------------------------------------------------------

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

;---------------------------------------------------------------------------------

PRINT PROC
    
    MOV AH, 09H
    INT 21H
    RET
    
PRINT ENDP

END
