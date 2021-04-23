; Block Transfer : To Perform overlapping block transfer

.8086
.MODEL SMALL
.STACK

; To move block from ARR to ARR1
.DATA
SIZE EQU 5
ARR DB 01H, 02H, 03H, 04H, 05H
ARR1 DB 2DUP(00H)

.CODE

MOV AX, @DATA
MOV DS, AX
MOV ES, AX

LEA SI, ARR
MOV AL, SIZE
DEC AL
MOV AH, 00H
ADD SI, AX
LEA DI, ARR1
ADD DI, 01H
STD
MOV CX, SIZE

REPZ
MOVSB 

MOV AX, 4C00H
INT 21H
END
