#INCLUDE 'PROTHEUS.CH'

/*
// ##############################################################################################
// Projeto: Exercicio para testar conhecimento em bloco de código
// Modulo : 
// Fonte  : zBlocos
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 24/06/2022   | Fernando Rodrigues   | Exercicio de bloco de código
// -------------+----------------------+---------------------------------------------------------*/

/*
-Criar o rdmake blocos.prw, adicionar o include "Protheus.ch" e criar a função blocos()
- Crie uma variável nItem com valor 450
- Crie uma variável nResultado tipo numérica
- criar uma variável de bloco de código bBloco1,  insira:
     - Variável "H" dentro do bloco "||"
      - variável "E" com valor 15
      - variável "Z" com valor 30
      - variável "R" com a conta "E" multiplicando "Z" e depois subtraia por "H"
Faça com a variável resultado assuma o valor do bloco , sendo que na função EVAL() deve passar o nItem no segundo parâmetro
*/
User Function zBloco()
    Local nItem := 500
    Local nResultado := 0
    Local bBloco1 := {||}
    Local E
    Local Z
    Local R

    bBloco1 := { |H| E:=15, Z:=30, R:=(E*Z)-H }

    nResultado := Eval(bBloco1, nItem)

    MsgAlert(cValToChar(nResultado), "Exercicio de Bloco")
Return
