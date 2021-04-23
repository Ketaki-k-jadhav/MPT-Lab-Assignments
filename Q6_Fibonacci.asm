;Program to find fibonacci sequence upto 'n' numbers

.8086
.model small
.stack 100
.data
        m1 db 0ah, 0dh, "Enter the number upto which you want to display the Fibonacci series: $"
        m2 db 0ah, 0dh, "Fibonacci series => $"
        m3 db 0ah, 0dh, " $ "
        n1 dw 0000h
        res1 dw 0000h
        res2 dw 0000h
        res dw 0000h
.code
        mov ax, @data
        mov ds, ax

        mov ah, 09h
        mov dx, offset m1
        int 21h

        call input

        mov n1, bx


        mov ah, 09h
        mov dx, offset m2
        int 21h

        call operation

        mov ax, 4c00h
        int 21h  
        
;-----------------------------------------------------------------------

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

;----------------------------------------------------------------------

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

;---------------------------------------------------------------------

operation proc
        mov si, n1
        mov res1, 00h
        mov res, 0000h
        call newline
        call dispres
        dec si
        mov res2, 01h
        mov res, 0001h
        call newline
        call dispres 
        dec si
    
  again:mov ax, res1
        mov bx, res2
        add ax, bx
        mov res, ax
        mov res1, bx
        mov res2, ax
        call newline
        call dispres
        dec si
        jnz again
    ret
operation endp  


;----------------------------------------------------------------------

newline proc
    mov ah, 09h
    mov dx, offset m3
    int 21h
    ret
newline endp



end 



