
TITLE Pedro Rodolfo Silva Galvão Santos (22886287) 
.model small
.data
.stack 100h


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









jmp FIM

DIVISAO:

 XOR CX,CX          ; Limpar o registrador CX, que vai ser usado como auxiliar na contagem desta OP
        CMP BL,0           ; Se o multiplicador(BL) for 0, jump para "X0"
        JE M0              ;
        MAUX1:             ; Segmento auxiliar da multiplicação 1
            SHR BL,1       ; Desloca o ultimo bit do multiplicador(BL) para direita, jogando em CF
            JC MAUX2       ; Se CF for 1, jump para AUX1, se ñ segue o codigo
            SHL BH,1       ; Desloca BH uma casa para direita 
            JMP MAUX1      ;
        MAUX2:             ; Segmento auxiliar da multiplicação 2
            ADD CH,BH      ; Adiciona o Numerador(BH) no produto(CH)
            SHL BH,1       ;    
            CMP BL,0       ; Enquanto o Multiplicador(BL) nao for zero, ñ pula para o resultado
            JNE MAUX1      ;
            MOV BH, CH     ; Joga o produto em BH, para ser processado pelo RESULT
            JMP RESULT     ;
        M0:                ; Multiplicação por 0
            XOR BH,BH      ; Zera BH
            JMP RESULT 
            
            
RESULT:                
      
    
        XOR AX,AX          ; Zera o registrador AX para ser utilizado 
        MOV AL,BH          ; Trás o resultado da operação para AL
   
        MOV BL,10          ;
        DIV BL             ;
        MOV BX,AX          ; Diviede os numeros e armazena em BH/BL

        MOV DL,BL          ;
        OR  DL,30h         ; 
        MOV AH,02h         ;
        INT 21h            ; Converte para caracter e imprime o primeiro digito
  
        MOV DL,BH          ;
        OR  DL,30h         ;
        MOV AH,2           ;
        INT 21h            ; Converte para caracter e imprime o segundo digito
               ; Vai formatar a "moldura" da calculadora
        JMP FIM            ; Jump para o fim da calculadora    ;





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









