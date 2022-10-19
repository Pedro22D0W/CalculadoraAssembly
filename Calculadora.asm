
.model small
.data

    msg1 DB 'selecione a operacao:',10,'soma:1',10,'subtracao:2',10,'multiplicacao:3',10,'divisao:4$'
    msg2 DB 'primeiro numero:$'
    msg3 DB 'segundo numero:$'
    msg4 DB 'resultado:$'
    msg5 DB 10


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
sub bl,30h
call PL

mov ah,09
lea dx,msg3
int 21h
call PL

mov ah,01
int 21h
mov bh,al
sub bh,30h
call Pl


mov ah,09
lea dx,msg1
int 21h
call PL

mov ah,01
int 21h

call PL









;cmp al,49H
;mp SOMA
;cmp bh,2
;jmp SUBTRACAO
cmp bh,3
jmp MULTIPLICACAO
;cmp al,52h
;jmp DIVISAO







SOMA:

add bl,bh



mov ah,09
lea dx,msg4
int 21h
call PL


mov dl,bl
or dl,30h
mov ah,02
int 21h



jmp FIM

SUBTRACAO:

sub bl,cl



mov ah,09
lea dx,msg4
int 21h
call PL


mov dl,bl
or dl,30h
mov ah,02
int 21h


jmp FIM

MULTIPLICACAO:

mov dl,0h
add dl,bl
sub bl,dl
mov cl,bh

mult2:

add bl,dl
loop mult2

mov ah,09
lea dx,msg4
int 21h
call PL


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









