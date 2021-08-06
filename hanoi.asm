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

    ;; Parâmetros de chamada de função [r0 = n, r5 = from_rod, r6 = to_rod, r7 = aux_rod]
    mov r0, r2
    loadn r5, #'A'
    loadn r6, #'C'
    loadn r7, #'B'
    ;; Chama função recursiva
    call torreHanoi

    halt

torreHanoi:
    ;; Salva valores
    push r0
    push r1
    push r2

    ;; Confere se n == 1
    loadn r3, #1
    cmp r3, r0
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

    ;breakp
    rts

    ;; loadn r1, #14
    ;; add r0, r0, r1
    ;; outchar r6, r0

naoUm:

    pop r2
    pop r1
    pop r0

    chamada_recursiva_1:
    ;; Parâmetros de chamada de função [r0 = n, r5 = from_rod, r6 = to_rod, r7 = aux_rod]
    ;; Trocando os parametros de ordem para nova chamada
    loadn r0, #num
    mov r4, r6
    mov r6, r7
    mov r7, r4
    ;; loadn r5, #'A'
    ;; loadn r6, #'C'
    ;; loadn r7, #'B'
    ;; Chama função recursiva
    call torreHanoi

    loadn r1, #moveUmP
    call printLinha

    ;; Exibe from_rod no local correto
    load r0, cursor
    loadn r1, #16
    sub r0, r0, r1
    outchar r5, r0
    inc r0

    chamada_recursiva_2:
    ;; Parâmetros de chamada de função [r0 = n, r5 = from_rod, r6 = to_rod, r7 = aux_rod]
    ;; Trocando os parametros de ordem para nova chamada
    loadn r0, #num
    mov r4, r5
    mov r5, r7
    mov r7, r4
    ;; loadn r5, #'A'
    ;; loadn r6, #'C'
    ;; loadn r7, #'B'
    ;; Chama função recursiva
    call torreHanoi

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

    loadn r2, #1200
    cmp r0, r2
    jel salvaLinha

zeraLinha:
    loadn r2, #0

salvaLinha:
    pop r2
    store cursor, r0

    pop r1

    rts
