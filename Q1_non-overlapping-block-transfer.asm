; Program to perform Non overlapping Block Transfer : From ARR -> ARR1
.8086
.MODEL SMALL
.STACK

.DATA
SIZE EQU 5
ARR DB 01H, 02H, 03H, 04H, 05H
ARR1 DB 5DUP(00H)


.CODE

MOV AX, @DATA
MOV DS, AX
MOV ES, AX

LEA SI, ARR
LEA DI, ARR1
CLD
MOV CX, SIZE

REPZ
MOVSB 



MOV AX, 4C00H
INT 21H



END
