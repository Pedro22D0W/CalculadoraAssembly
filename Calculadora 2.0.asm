TITLE Pedro Rodolfo Silva Galvão Santos (22886287) Murilo Montebello (22018897) 
.model small
.data
.stack 100h

    msg1 DB 'selecione a operacao:',10,'soma:1',10,'subtracao:2',10,'multiplicacao:3',10,'divisao:4$'
    msg2 DB 'primeiro numero:$'
    msg3 DB 'segundo numero:$'
    msg4 DB 10,'resultado:$'
    msg5 DB "-$"
    msg6 DB 'o divisor nao pode ser',10,'maior que o dividendo!$'
    msg7 DB "o resto da divisao e:$"
    msg8 DB "inderteminacao matematica!$"
    msgA DB '+$'
    msgB DB 'x$'
    msgC DB '========================$'
    msgG DB '/$'
    msgH DB 'Realizar nova operacao?',10,'nao:1',10,'sim:2$'
.code



main PROC

;inicializa DS
    mov ax,@data 
    mov ds,ax    


inicio:
    mov ah,09
    lea dx,msgC
    int 21h
    call PL


;função 09 para exibir mensagem na tela
    mov ah,09    
    lea dx,msg1
    int 21h

    call PL  ;<----"chama PL(pular linha)"

;função 01 para o usuario selecionar numero da operaçao 
    mov ah,01
    int 21h
    MOV ch,al;<----move numero da operação selecionada para liberar al

    call Pl  ;<----"chama PL(pular linha)"

   mov ah,09
    lea dx,msgC
    int 21h
    call PL


;função 09 para exibir mensagem na tela
    mov ah,09
    lea dx,msg2
    int 21h
    
;função 01 para o usuario digitar o primeiro numero 
    mov ah,01   
    int 21h
    mov bl,al
  call Pl
    call Pl
;função 09 para exibir mensagem na tela
    mov ah,09
    lea dx,msg3
    int 21h

;função 01 para o usuario digitar o primeiro numero 
    mov ah,01
    int 21h
    mov bh,al

    
    call Pl     ;<----"chama PL(pular linha)"
    call Pl     ;<----"chama PL(pular linha)"



;compara numero selecionado com o numero da operação e pula para operação selecionada
    cmp ch,031h
    JE SOMA0
    cmp ch,032h
    JE SUBTRACAO0
    cmp ch,033h
    je MULTIPLICACAO0
    cmp ch,034h
    je DIVISAO0

;chama operação selecionada e pula para resultado
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
call DIVISAO
jmp divv_resultado ;<---- pula para resultado da divisão,que contem resto

resultado:
and bl,0fh ;<----tranforma caracter em numero
and bh,0fh ;<----tranforma caracter em numero

xor cx,cx          ;<---- zera cx para fazer a divsão afim de representar numero de 2 digitos
mov cl,10          ;<---- move divisor 10 para cl 
xor ax,ax          ;<---- zera ca para fazer a divsão afim de representar numero de 2 digitos
mov al,bl          ;<---- move resultado da operaçao realizada para al,(dividendo)
div cl             ;<---- divide resultado da operação por 10,o Quociente representa a dezena e o resto a unidade

mov bh,al          ;<---- move dezena para bh
mov bl,ah          ;<---- move unidade para bl

;função 09 para exibir mensagem na tela
mov ah,09
lea dx,msg4
int 21h



;função 02 para exibir dezena do resultado na tela
mov dl,bh
or dl,30h
mov ah,02
int 21h

;função 02 para exibir unidade do resultado na tela
mov dl,bl
or dl,30h       ;<----tranforma numero em caracter
mov ah,02
int 21h
call Pl

mov ah,09
lea dx,msgC
int 21h
call PL

jmp FIM         ;<----pula para fim do programa

divv_resultado: ;<----resultado de divisao,contem resto

mov cl,10       ;<---- move divisor 10 para cl 
xor ax,ax       ;<---- zera ax para fazer a divsão afim de representar numero de 2 digitos
mov al,bl       ;<---- move resultado da operaçao realizada para al,(dividendo)
div cl          ;<---- divide resultado da operação por 10,o Quociente representa a dezena e o resto a unidade

mov bh,ah       ;<---- move dezena para bh
mov bl,al       ;<---- move unidade para bl


;função 09 para exibir mensagem na tela
mov ah,09
lea dx,msg4
int 21h



;função 02 para exibir dezena do resultado na tela
mov dl,bl
or dl,30h
mov ah,02
int 21h


;função 02 para exibir unidade do resultado na tela
mov dl,bh
or dl,30h
mov ah,02
int 21h

call PL        ;<----"chama PL(pular linha)"
call Pl         ;<----"chama PL(pular linha)"
;função 09 para exibir mensagem na tela
mov ah,09
lea dx,msg7
int 21h


mov cl,10      ;<---- move divisor 10 para cl 
xor ax,ax      ;<---- zera ax para fazer a divsão afim de representar numero de 2 digitos
mov al,ch      ;<---- move resto da operaçao realizada para al,(dividendo)
div cl         ;<---- divide resto da operação por 10,o Quociente representa a dezena e o resto a unidade

mov bh,ah       ;<---- move dezena para bh
mov bl,al       ;<---- move unidade para bl


;função 02 para exibir dezena do resto na tela
mov dl,bl
or dl,30h
mov ah,02
int 21h

;função 02 para exibir unidade do resto na tela
mov dl,bh
or dl,30h
mov ah,02
int 21h
call Pl ;<----"chama PL(pular linha)"


mov ah,09
    lea dx,msgC
    int 21h

jmp FIM      ;<----pula para fim do programa





SOMA PROC
mov dl,bl
mov ah,02
int 21h

mov ah,09
lea dx,msgA
int 21h

mov dl,bh
mov ah,02
int 21h

call Pl

add bl,bh       ;soma primeiro numero digitado com o segundo
RET             ;retorna para onde o call foi solicitado

SOMA endp



SUBTRACAO PROC
mov dl,bl
mov ah,02
int 21h

mov ah,09
lea dx,msg5
int 21h

mov dl,bh
mov ah,02
int 21h

call Pl


cmp bl,bh       ;compara o primero numero com o segundo
jl NEGATIVO     ;se o primeiro for menor pula para representação de numero negativo

sub bl,bh       ;subtrai do primeiro numero o segundo numero
RET             ;retorna para onde o call foi solicitado

NEGATIVO:       ;<---- representação de numero negativo

xchg bl,bh      ;inverte posição dos numeros
sub bl,bh       ;subtrai o segundo numero digitado com o primeiro

;função 09 para exibir mensagem na tela
mov ah,09
lea dx,msg4
int 21h

call PL         ;<----"chama PL(pular linha)"

;função 09 para exibir sinal '-'antes do numero
mov ah,09
lea dx,msg5
int 21h

or bl,30h       ;<---- tranforma numero em caracter
mov dl,bl
mov ah,02
int 21h

jmp FIM         ;<----pula para fim do programa

SUBTRACAO ENDP


MULTIPLICACAO PROC
mov dl,bl
mov ah,02
int 21h

mov ah,09
lea dx,msgB
int 21h

mov dl,bh
mov ah,02
int 21h

call Pl

xor dx,dx       ;<---- zera dx para armazenar o resultado
xor cx,cx       ;<---- zera cx para iniciar contador
mov cl,5        ;<---- adiciona 5 ao contador(numero de bits para representar numeros de 1 digito)

mult1:  ;<---- multiplicação baseada ma multiplicação no papel 

shr bl,1        ;<---- desloca primeiro numero uma casa para esquerda afim de checar o bit menos significativo
jc addd         ;<---- checa carry que contem o bit menos significativo,se igual a 1 pula para addd
shl bh,1        ;<---- se o menos significativo(no carry) for 0,desloca segundo numero 1 casa para esquerda
loop mult1      ;<---- refaz procediemento até cx ser igual a zero
mov bl,dh       ;<---- move resultado para bl
RET             ;<---- retorna para onde o call foi solicitado

addd:
add dh,bh       ;<---- adiciona no resultado segundo numero
shl bh,1        ;<---- desloca segundo numero 1 casa para esquerda
loop mult1      ;<---- refaz procediemento até cx ser igual a zero
mov bl,dh       ;<---- move resultado para bl
RET             ;<---- retorna para onde o carry foi solicitado

MULTIPLICACAO ENDP


DIVISAO:

mov dl,bl
mov ah,02
int 21h

mov ah,09
lea dx,msgG
int 21h

mov dl,bh
mov ah,02
int 21h
call PL

and bl,0fh ;<----tranforma caracter em numero
and bh,0fh ;<----tranforma caracter em numero
cmp bh,bl                       ;<---- compara divisor com o dividendo 
jg divv_maior_que_dividendo     ;<---- se o divisor for maior que o dividendo pula para exibir mensagem de impossibilidade
cmp bh,0                        ;<---- compara divisor com 0 
je inderteminacao               ;<---- se o divisor 0 pula para exibir mensagem de inderteminação




mov dh,bh       ;<---- move o divisor para dh

xor ax,ax       ;<---- zera ax para armazenar o dividendo
mov al,bl       ;<---- move o dividendo para al
xor dl,dl       ;<---- zera dl para poder manipular o divisor 
xor bx,bx       ;<---- zera bx para armazenar o resultado



mov cx,9       ;<----- adiciona 9 no contador para trabalhar com 9 bits

divv:
sub ax,dx      ;<----- subtrai divisor do dividendo
jns subb1      ;<----- se o resultado da divisão não for negativo não reverte o processo
add ax,dx      ;<----- reverte o processo 
mov bh,0       ;<----- adiciona 0 nos bits do resultado
jmp subb2      ;<----- pula para 

subb1:
mov bh,1       ;<----- adiciona 1 nos bits do resultado

subb2:
shl bl,1       ;<----- desloca resultado 1 casa para esquerda
or bl,bh       ;<----- adicina bit (0 ou 1) na casa certa
shr dx,1       ;<----- desloca divisor uma casa para direita
loop divv      ;<----- refaz procediemento até cx ser igual a zero
mov ch,al      ;<----- move o resto para ch
RET            ;<----- retorna para onde o call foi solicitado


divv_maior_que_dividendo:  ;<---- exibe mensagem de divisor maior que o dividendo na tela
call PL
mov ah,09
lea dx,msg6
int 21h
call PL
    mov ah,09
    lea dx,msgC
    int 21h
    call PL
jmp FIM



inderteminacao:            ;<---- exibe mensagem de inderteminação matematica na tela
call Pl
mov ah,09
lea dx,msg8
int 21h
call PL
    mov ah,09
    lea dx,msgC
    int 21h
    call PL
jmp FIM


PL PROC   ;<---- pula linha
    
    mov ah,02
    mov dl,10
    int 21h
    RET
    
PL ENDP

    Voltar:
    jmp inicio


FIM:   ;<---- fim do codigo
    call Pl
    mov ah,09
    lea dx,msgH
    int 21h
    call PL

    mov ah,01
    int 21h
    and al,0fh
    cmp al,02h
    call PL
    je Voltar

mov ah,4ch
int 21h

main ENDP
end main
