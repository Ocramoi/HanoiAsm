# HanoiAsm
Solução recursiva do problema da Torre de Hanoi em assembly para o [Processador ICMC](https://github.com/simoesusp/Processador-ICMC), desenvolvida como trabalho final de SSC0119 - Prática em Organização de Computadores, pelos alunos [Marco Toledo](https://github.com/Ocramoi) e [Vitor Brustolin](https://github.com/VitorBrust1).

## Uso
Com o repositório clonado/baixado, entre na pasta do projeto e compile o simulador e montador, copiando seus executáveis para a página de projeto como no seguinte exemplo:

``` sh
cd montador_fonte
gcc *.c -o montador
cp montador ..

cd ../simulador_fonte
sh compila.sh
cp sim ..
cd ..
```

Agora, no diretório principal, monte o arquivo .asm com
``` sh
./montador hanoi.asm hanoi.mif
```
e execute o simulador com 
``` sh
./sim hanoi.mif charmap.mif
```

## Apresentação
O vídeo de apresentação do projeto pode ser conferido [pelo link](https://github.com/Ocramoi/HanoiAsm/blob/main/Apresentacao.mp4?raw=true)

## Modificações no simulador/montador
Para o acrescimo no emulador no processor, foi adicionada a montagem e simulação da instrução `pow`, devidamente adicionada ao manual. Essa função funciona no formato:

`pow rx, ry, rz`: rx <- ry<sup>rz</sup>

