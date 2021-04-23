;Program for multiplication using rotation and addition


.8086
.model small
.stack 100
.data
        m1 db 0ah, 0dh, "Enter first number(8-bit): $"
        m2 db 0ah, 0dh, "Enter second number(8-bit): $"
        m3 db 0ah, 0dh, "Result of multiplication using rotation and addition => $"
        n1 db 00h
        n2 db 00h
        res dw 0000h
.code
        mov ax, @data
        mov ds, ax

        mov ah, 09h
        mov dx, offset m1
        int 21h

        call input

        mov n1, bl

        mov ah, 09h
        mov dx, offset m2
        int 21h

        call input

        mov n2, bl

        mov ah, 09h
        mov dx, offset m3
        int 21h

        call perform

        call dispres

        mov ax, 4c00h
        int 21h
;-------------------------------------------------------------------------------

input proc
        mov ch, 02h
        mov cl, 04h
        mov bl, 00h

  back: shl bl, cl
        mov ah, 01h
        int 21h
        cmp al, 41h
        jb next
        sub al, 07h
  next: sub al, 30h
        add bl, al
        dec ch
        jnz back
        ret
input endp
            
;--------------------------------------------------------------------------------           
            
perform proc
        mov cl, 16h
        mov ax, 0000h
        mov bl, n1
        mov dl, n2
    
  again:rcr dl, 01h
        jnc L1
        add ax, bx
    
     L1:shl bx, 01h
        dec cl
        jnz again
        mov res, ax
     ret
perform endp 

;--------------------------------------------------------------------------------

dispres proc

        mov ch, 04h
        mov cl, 04h
        mov bx, res

   bat1: rol bx, cl
        mov dl, bl
        and dl, 0fh
        cmp dl, 0ah
        jb lat1
        add dl, 07h
   lat1:add dl, 30h

        mov ah, 02h
        int 21h

        dec ch
        jnz bat1
	ret
dispres endp


end
  
  
   