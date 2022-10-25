
.model small
.data

    msg1 DB 'selecione a operacao:',10,'soma:1',10,'subtracao:2',10,'multiplicacao:3',10,'divisao:4$'
    msg2 DB 'primeiro numero:$'
    msg3 DB 'segundo numero:$'
    msg4 DB 10,'resultado:$'
    msg5 DB "-$"


.code

main PROC

mov ax,@data 
mov ds,ax

mov ah,09
lea dx,msg2
int 21h
call PL



mov ah,01
int 21h
mov bl,al
and bl,0fh
call PL

mov ah,09
lea dx,msg3
int 21h
call PL

mov ah,01
int 21h
mov bh,al
and bh,0fh
call Pl


mov ah,09
lea dx,msg1
int 21h
call PL

mov ah,01
int 21h











cmp al,031h
je SOMA
cmp al,032h
jp SUBTRACAO
cmp al,033h
je MULTIPLICACAO
cmp al,034h
jmp DIVISAO







SOMA:
mov cl,10
add bl,bh
xor ax,ax
mov al,bl
div cl

mov bh,al
mov bl,ah





mov ah,09
lea dx,msg4
int 21h
call PL

mov dl,bh
or dl,30h
mov ah,02
int 21h



mov dl,bl
or dl,30h
mov ah,02
int 21h







jmp FIM

SUBTRACAO:

cmp bl,bh
jl NEGATIVO

sub bl,bh



mov ah,09
lea dx,msg4
int 21h
call PL

mov dl,bl
add dl,30h
mov ah,02
int 21h





jmp FIM

NEGATIVO:

xchg bl,bh
sub bl,bh

mov ah,09
lea dx,msg4
int 21h
call PL

mov ah,09
lea dx,msg5
int 21h

or bl,30h
mov dl,bl
mov ah,02
int 21h

jmp FIM


MULTIPLICACAO:
add dh,0h
xor ax,ax
add al,bl
mov cl,bh
addsub:
add dh,al

loop addsub
mov cl,bl

mult2:

mov dl,10
shl bh,1



loop mult2
sub bh,dh
sub bh,dh
sub bh,dh
sub bh,dh





xor ax,ax
mov al,bh
div dl



mov bh,al
mov bl,ah





mov ah,09
lea dx,msg4
int 21h
call PL

mov dl,bh
or dl,30h
mov ah,02
int 21h



mov dl,bl
or dl,30h
mov ah,02
int 21h







jmp FIM

DIVISAO:

jmp FIM





PL PROC
    
    mov ah,02
    mov dl,10
    int 21h
    RET
    
PL ENDP






FIM:
mov ah,4ch
int 21h

main ENDP
end main









