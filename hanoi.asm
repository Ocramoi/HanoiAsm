jmp main

    ;; Variáveis globais de programa
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

    ;; Exibe cabeçalho
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

    ;; Chamada POW de teste
    loadn r1, #2
    loadn r2, #10
    pow r0, r1, r2

    halt

torreHanoi:
    ;; Salva valores
    push r0
    push r1
    push r2

    ;; Confere se n == 1 para continuar
    loadn r1, #1
    cmp r1, r4
    jne naoUm

    ;; Caso n == 1 exibe string
    loadn r1, #moveUmP
    call printLinha

    ;; Exibe torre de origem no local correto
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

    ;; Exibe torre de destino no local correto
    load r0, cursor
    loadn r1, #1
    sub r0, r0, r1
    outchar r6, r0

    jmp fimChamada

;; Caso tenha seguido o código
naoUm:
    ;; Salva ponteiros
    push r1
    push r4
    push r5
    push r6
    push r7

    ;;  (origem = aux, aux = origem)
    mov r1, r7
    mov r7, r6
    mov r6, r1
    ;; (n -= 1)
    loadn r1, #1
    sub r4, r4, r1
    ;; Chama recursviamente
    call torreHanoi

    ;; Retoma valores
    pop r7
    pop r6
    pop r5
    pop r4
    pop r1

    ;; Exibe string de disco
    loadn r1, #moveDiscoN
    call printLinha

    ;; Exibe disco no local correto
    ;; Calcula posição da linha
    load r0, cursor
    loadn r1, #27
    sub r0, r0, r1
    ;; Calcula caracter referente ao index do disco
    push r4
    push r1
    loadn r1, #48
    add r4, r1, r4
    ;; Exibe no local correto
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

    ;; Exibe torre de origem no local correto
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

    ;; Exibe torre de destino no local correto
    load r0, cursor
    loadn r1, #1
    sub r0, r0, r1
    outchar r6, r0
    inc r0

    ;; Salva ponteiros
    push r1
    push r4
    push r5
    push r6
    push r7

    ;; (origem = aux, aux = origem)
    mov r1, r5
    mov r5, r7
    mov r7, r1

    ;; (n -= 1)
    loadn r1, #1
    sub r4, r4, r1
    ;; Chamada recursiva
    call torreHanoi

    ;; Retoma valores salvos para recursão
    pop r7
    pop r6
    pop r5
    pop r4
    pop r1

;; Retoma valores iniciais da função recursiva e retoma PC
fimChamada:
    pop r2
    pop r1
    pop r0

    rts

;; Lê valor digitado, limitado de ['1', '9']
leNum:
    ;; Lê entrada
    inchar r2

    ;; Confere se menor que '1'
    loadn r1, #49
    cmp r2, r1
    jle leNum

    ;; Confere se maior que '9'
    loadn r1, #57
    cmp r2, r1
    jgr leNum

    ;; Retorna valor lido
    rts

;; Exibe #string carrega em r1 no cursor atual em r0
printStr:
    ;; Salva valores
    push r0
    push r1
    push r2
    push r3
    push r4

    ;; Carrega condição de parada
    loadn r3, #'\0'

;; Exibe carater atual
loopPrint:
    ;; Carrega caracter da posição de memória
    loadi r4, r1
    cmp r4, r3
    ;; Confere condição de saída (char = '\0')
    jeq saiPrint

    ;; Exibe caracter
    outchar r4, r0
    ;; Carrega próximo byte
    inc r1
    inc r0
    ;; Chamada recursiva
    jmp loopPrint

;; Retoma valores salvos e retorna ao PC salvo no final da impressão
saiPrint:
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0

    rts

;; Limpa a tela em loop pelos chars de vídeo
limpaTela:
    ;; SAlva valores
    push r0
    push r1
    push r2

    ;; Carrega contador, char em branco e condição de parada do loop
    loadn r0, #0
    loadn r1, #1200
    loadn r2, #0

;; Limpa carater a caracter
loopLimpa:
    ;; Confere condição de parada
    cmp r0, r1
    jeg fimLoopLimpa

    ;; Limpa char atual
    outchar r2, r0

    ;; Próximo char
    inc r0
    ;; Chama recursiva
    call loopLimpa

;; Retoma valores salvo e volta ao PC salvo
fimLoopLimpa:
    pop r2
    pop r1
    pop r0

    rts

;; Printa #string de r1 na posição atual da variável global de cursor
printLinha:
    ;; Carrega posição de cursor
    load r0, cursor
    ;; Exibe string em r1
    call printStr

    ;; Salva registro
    push r1

    ;; Pula para a próxima linha
    loadn r1, #40
    add r0, r0, r1

    ;; Confere final de tela
    push r2
    loadn r2, #1160
    cmp r0, r2
    jel salvaLinha

;; Caso final de tela, limpa e retorna para o topo da tela
zeraLinha:
    loadn r2, #0
    store cursor, r2
    call limpaTela

    pop r2
    pop r1

    rts

;; Salva linha atual do cursor
salvaLinha:
    pop r2
    store cursor, r0
    pop r1

    rts
