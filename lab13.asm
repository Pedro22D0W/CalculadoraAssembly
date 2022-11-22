.model small
.data

msg1 db "digite o numero:$"

.code


main proc 

mov ax,@data
mov ds,ax

mov ah,09
lea dx,msg1
int 21h

mov ah,01
int 21h
xor bx,bx
cmp al,2dh
je NEGATIVO

op:
mov ah,01
int 21h
cmp al,2dh
je poss

and al,0fh
mov cl,10
mul cl
add bx,ax
jmp op

poss:

mov ch,2bh
jmp escrita




NEGATIVO:

op2:

mov ah,01
int 21h
cmp al,0dh
je negg

and al,0fh
mov cl,10
mul cl
add bx,ax
jmp op2

negg:
neg bx
mov ch,2dh

escrita:

mov ah,02
mov dl,ch
int 21h
mov ax,bx
xor bx,bx
xor cx,cx
mov cl,5
mov ch,10
escc:

div ch
mov bl,al
mov ah,02
mov dl,bl
int 21h
loop escc

mov ah,4ch
int 21h
main endp
end main








