%include "io64.inc"
section .data

    cpf db 1,7,8,8,6,3,2,7,0,2,0
section .text
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging
    
    mov r14,1    ;;Bool: 1 - Valido   2 - Invalido
    mov r10, 10  ;;Contador da Primeira Verificação e Multiplicador x 10
    mov r11, 11  ;;Contador da Segunda Verificação
    
    xor rax,rax  
    xor rdx,rdx
    xor rsi, rsi ;;Indice
    xor r8,r8    ;;Soma das Multiplicações
    
    
    primeiraVerificacao:
        mov rax, 0
        mov al, r10b 
        mul byte [cpf + rsi]
        add r8, rax
        
        inc rsi
        dec r10
        cmp r10,1
    jg primeiraVerificacao
    
    
    mov ax,r8w
    mov r10w,10
    mul r10w ;;Multiplica a soma por 10
    div r11d ;;Divide o resultado da multiplicação por 11
    
    cmp dl, [cpf + 9] ;;Compara o resto da divisão com o 10 digito
    jne diferente 
    
    xor rdx,rdx
    xor r8,r8
    xor rsi, rsi
    mov r10,11
    
    segundaVerificacao:
        mov rax, 0
        mov al, r10b 
        mul byte [cpf + rsi]
        add r8, rax
        
        inc rsi
        dec r10
        cmp r10,1
    jg segundaVerificacao
    
    mov ax,r8w
    mov r10w,10
    mul r10w ;;Multiplica a soma por 10
    div r11d ;;Divide o resultado da multiplicação por 11
    
    cmp dl, [cpf + 10] ;;Compara o resto da divisão com o 10 digito
    je fimDoCodigo
    
    
    diferente:
        mov r14, 0
    
    fimDoCodigo:
        ret