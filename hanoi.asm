;; https://www.geeksforgeeks.org/c-program-for-tower-of-hanoi/

jmp main

initCabecalho: string "####################"
initTitulo: string "#  TORRE DE HANOI  #"
entradaNum: string "Numero de discos da torre [1-9]: "
moveUmP:    string "Mova o disco 1 da torre "
moveUmS:    string " para a torre "
moveDiscoN:    string "Mova o disco "
moveDiscoO:    string " da torre "
moveDiscoD:    string " para a torre "

cursor:     var #1
num:        var #1

main:
    ;; Inicializa cursor de print linha
    loadn r0, #0
    store cursor, r0

    ;; exibe cabeçalho
    loadn r1, #initCabecalho
    call printLinha

    loadn r1, #initTitulo
    call printLinha

    loadn r1, #initCabecalho
    call printLinha

    loadn r1, #entradaNum
    call printLinha

    ;; Lê número de discos desejado
    call leNum

    ;; Exibe valor lido em caracter
    loadn r0, #153
    outchar r2, r0

    ;; Salva valor lido como int
    loadn r0, #48
    sub r2, r2, r0
    store num, r2

    ;; Parâmetros de chamada de função [r4 = n, r5 = from_rod, r6 = to_rod, r7 = aux_rod]
    mov r4, r2
    loadn r5, #'A'
    loadn r6, #'C'
    loadn r7, #'B'

    ;; Chama função recursiva
    call torreHanoi

    loadn r1, #2
    loadn r2, #10
    pow r0, r1, r2

    halt

torreHanoi:
    ;; Salva valores
    push r0
    push r1
    push r2

    ;; Confere se n == 1
    loadn r1, #1
    cmp r1, r4
    jne naoUm

    ;; Caso n == 1 exibe string
    loadn r1, #moveUmP
    call printLinha

    ;; Exibe from_rod no local correto
    load r0, cursor
    loadn r1, #16
    sub r0, r0, r1
    outchar r5, r0
    inc r0

    load r0, cursor
    loadn r1, #15
    sub r0, r0, r1
    loadn r1, #moveUmS
    call printStr

    ;; Exibe from_rod no local correto
    load r0, cursor
    loadn r1, #1
    sub r0, r0, r1
    outchar r6, r0

    jmp fimChamada

naoUm:
    push r1
    push r4
    push r5
    push r6
    push r7

    mov r1, r7
    mov r7, r6
    mov r6, r1
    loadn r1, #1
    sub r4, r4, r1
    call torreHanoi

    pop r7
    pop r6
    pop r5
    pop r4
    pop r1


    ;; Exibe string
    loadn r1, #moveDiscoN
    call printLinha

    ;; Exibe disco no local correto
    load r0, cursor
    loadn r1, #27
    sub r0, r0, r1

    push r4
    push r1
    loadn r1, #48
    add r4, r1, r4
    outchar r4, r0
    pop r1
    pop r4

    ;; Exibe string intermediária no local correto
    push r0
    push r1
    load r0, cursor
    loadn r1, #26
    sub r0, r0, r1
    loadn r1, #moveDiscoO
    call printStr
    pop r1
    pop r0

    ;; Exibe from_rod no local correto
    load r0, cursor
    loadn r1, #16
    sub r0, r0, r1
    outchar r5, r0
    inc r0

    ;; Exibe string final no local correto
    load r0, cursor
    loadn r1, #15
    sub r0, r0, r1
    loadn r1, #moveDiscoD
    call printStr

    ;; Exibe _rod no local correto
    load r0, cursor
    loadn r1, #1
    sub r0, r0, r1
    outchar r6, r0
    inc r0

    push r1
    push r4
    push r5
    push r6
    push r7

    mov r1, r5
    mov r5, r7
    mov r7, r1

    loadn r1, #1
    sub r4, r4, r1
    call torreHanoi

    pop r7
    pop r6
    pop r5
    pop r4
    pop r1

fimChamada:
    pop r2
    pop r1
    pop r0

    rts

leNum:
    inchar r2

    loadn r1, #49
    cmp r2, r1
    jle leNum

    loadn r1, #57
    cmp r2, r1
    jgr leNum

    rts

printStr:
    push r0
    push r1
    push r2
    push r3
    push r4

    loadn r3, #'\0'

loopPrint:
    loadi r4, r1
    cmp r4, r3
    jeq saiPrint

    outchar r4, r0
    inc r1
    inc r0
    jmp loopPrint

saiPrint:
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0

    rts

limpaTela:
    push r0
    push r1
    push r2

    loadn r0, #0
    loadn r1, #1200
    loadn r2, #0

loopLimpa:
    cmp r0, r1
    jeg fimLoopLimpa

    outchar r2, r0

    inc r0
    call loopLimpa

fimLoopLimpa:

    pop r2
    pop r1
    pop r0

    rts

printLinha:
    load r0, cursor
    call printStr

    push r1

    loadn r1, #40
    add r0, r0, r1

    push r2

    loadn r2, #1160
    cmp r0, r2
    jel salvaLinha

zeraLinha:
    loadn r2, #0
    store cursor, r2
    ;; breakp
    call limpaTela

    pop r2
    pop r1

    rts

salvaLinha:
    pop r2
    store cursor, r0
    pop r1

    rts
