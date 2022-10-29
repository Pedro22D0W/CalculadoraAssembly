
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
MOV bl,al
call Pl




  












cmp bl,031h
JE SOMA0
cmp bl,032h
JE SUBTRACAO0
cmp bl,033h
je MULTIPLICACAO0
cmp bl,034h
je DIVISAO0

jmp fim

SOMA0:
call SOMA
jmp fim
SUBTRACAO0:
call SUBTRACAO
jmp fim
MULTIPLICACAO0:
call MULTIPLICACAO
jmp FIM
DIVISAO0:
jmp DIVISAO
jmp FIM








SOMA PROC

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
RET

SOMA endp



SUBTRACAO PROC

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

RET

SUBTRACAO ENDP


MULTIPLICACAO:

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

xor dx,dx
mov cl,5

mult1:

shr bl,1
jc addd
shl bh,1
loop mult1
mov bh,dh
jmp resultado

addd:
add dh,bh
shl bh,1
loop mult1







resultado:

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










RET

DIVISAO:

mov ax,@data 
mov ds,ax

mov ah,09
lea dx,msg2
int 21h
call PL



mov ah,01
int 21h
and al,0fh
mov cl,10
mul cl
mov bl,al
mov ah,01
int 21h
and al,0fh
add bl,al
call PL

mov ah,09
lea dx,msg3
int 21h
call PL
mov ah,01
int 21h
and al,0fh
mov cl,10
mul cl
mov bh,al
mov ah,01
int 21h
and al,0fh
add bh,al

add ch,bh
add cl,bl
shr ch,1
shr cl,1
add ch,ch
cmp ch,cl
jg Maior

xor dx,dx
xor cx,cx
add dl,bl
add cl,bh
jmp parouimpar0


maior:

sub bl,bh
mov dl,bl
mov dh,1
jmp resultado2

parouimpar0:
cmp bl,bh
jg parouimpar

call PL

mov ah,09
lea dx,msg6
int 21h
call PL
jmp FIM


parouimpar:

shr bl,1
jc impar
jmp par



par:



shl cl,1         ;multiplica o divisor por 2
;add ch,dl        ;adiciona o divisor em ch
add dh,2         ;adiciona 2 em numero de vezes que o multiplicador cabe dentro do divisor 
     

sub dl,cl        ;subtrai o divisor duas vezes do diviendo
shr cl,1 
xor bl,bl
add bl,dl

cmp cl,dl
je iguais
cmp dl,0
je iguala0
cmp dl,0
jl menorque01
cmp dl,cl
jl menorquedivisor
jmp parouimpar



impar:

sub bl,1


shl cl,1         ;multiplica o divisor por 2
;add ch,dl        ;adiciona o divisor em ch
add dh,3         ;adiciona 3 em numero de vezes que o multiplicador cabe dentro do divisor 


sub dl,cl 
shr cl,1        ;subtrai o divisor duas vezes do diviendo
sub dl,cl
xor bl,bl
add bl,dl

cmp cl,dl
je iguais
cmp dl,0
je iguala0
cmp dl,0
jl menorque02
cmp dl,cl
jl menorquedivisor
jmp parouimpar


iguais:
sub dl,cl
add dh,1

jmp resultado2

iguala0:
jmp resultado2


menorquedivisor:
jmp resultado2



menorque01:
add dl,cl
add dl,cl
sub dl,cl
sub dh,1
jmp resultado2


menorque02:
add dl,cl
add dl,cl
add dl,cl
sub dl,cl
sub dl,cl
sub dh,1
jmp resultado2







resultado2:

mov ch,dh



mov cl,10
xor ax,ax
mov al,ch
div cl

mov ch,ah
mov cl,al

mov bl,dl

mov ah,09
lea dx,msg4
int 21h
call PL



mov dl,cl
or dl,30h
mov ah,02
int 21h



mov dl,ch
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
mov al,bl
div cl

mov ch,ah
mov cl,al



mov dl,cl
or dl,30h
mov ah,02
int 21h

mov dl,ch
or dl,30h
mov ah,02
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









