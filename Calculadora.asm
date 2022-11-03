
TITLE Pedro Rodolfo Silva Galvão Santos (22886287) 
.model small
.data
.stack 100h


    msg1 DB 'selecione a operacao:',10,'soma:1',10,'subtracao:2',10,'multiplicacao:3',10,'divisao:4$'
    msg2 DB 'primeiro numero:$'
    msg3 DB 'segundo numero:$'
    msg4 DB 10,'resultado:$'
    msg5 DB "-$"
    msg6 DB "o divisor nao pode ser maior que o dividendo!$"
    msg7 DB "o resto da divisao e:$"
    msg8 DB "inderteminacao matematica!$"


.code



main PROC


mov ax,@data 
mov ds,ax




mov ah,09
lea dx,msg1
int 21h
call PL

mov ah,01
int 21h
MOV ch,al
call Pl

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


cmp ch,031h
JE SOMA0
cmp ch,032h
JE SUBTRACAO0
cmp ch,033h
je MULTIPLICACAO0
cmp ch,034h
je DIVISAO0

jmp fim

SOMA0:
call SOMA
jmp resultado
SUBTRACAO0:
call SUBTRACAO
jmp resultado
MULTIPLICACAO0:
call MULTIPLICACAO
jmp resultado
DIVISAO0:
jmp DIVISAO
jmp resultado

resultado:

xor cx,cx
mov cl,10
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

divv_resultado:

mov cl,10
xor ax,ax
mov al,bl
div cl

mov bh,ah
mov bl,al


mov ah,09
lea dx,msg4
int 21h
call PL



mov dl,bl
or dl,30h
mov ah,02
int 21h



mov dl,bh
or dl,30h
mov ah,02
int 21h

call PL


mov ah,09
lea dx,msg7
int 21h
call PL

mov cl,10
xor ax,ax
mov al,ch
div cl

mov bh,ah
mov bl,al



mov dl,bl
or dl,30h
mov ah,02
int 21h

mov dl,bh
or dl,30h
mov ah,02
int 21h

jmp FIM





SOMA PROC

add bl,bh
RET

SOMA endp



SUBTRACAO PROC

mov ax,@data 
mov ds,ax



cmp bl,bh
jl NEGATIVO

sub bl,bh
RET

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

SUBTRACAO ENDP


MULTIPLICACAO PROC
xor dx,dx
xor cx,cx
mov cl,5

mult1:

shr bl,1
jc addd
shl bh,1
loop mult1
mov bl,dh
RET

addd:
add dh,bh
shl bh,1
loop mult1
mov bl,dh
RET
MULTIPLICACAO ENDP


DIVISAO:

cmp bh,bl
jg divv_maior_que_dividendo
cmp bh,0
je inderteminacao




mov dh,bh

xor ax,ax
mov al,bl
xor dl,dl
xor bx,bx



mov cx,9

divv:
sub ax,dx
jns subb1
add ax,dx
mov bh,0
jmp subb2

subb1:
mov bh,1

subb2:
shl bl,1
or bl,bh
shr dx,1
loop divv
mov ch,al
jmp divv_resultado

divv_maior_que_dividendo:
mov ah,09
lea dx,msg6
int 21h
jmp FIM
inderteminacao:
mov ah,09
lea dx,msg8
int 21h
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