#INCLUDE 'PROTHEUS.CH'

/*
// ##############################################################################################
// Projeto: Exercicio para testar conhecimento em bloco de c�digo
// Modulo : 
// Fonte  : zBlocos
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 24/06/2022   | Fernando Rodrigues   | Exercicio de bloco de c�digo
// -------------+----------------------+---------------------------------------------------------*/

/*
-Criar o rdmake blocos.prw, adicionar o include "Protheus.ch" e criar a fun��o blocos()
- Crie uma vari�vel nItem com valor 450
- Crie uma vari�vel nResultado tipo num�rica
- criar uma vari�vel de bloco de c�digo bBloco1,  insira:
     - Vari�vel "H" dentro do bloco "||"
      - vari�vel "E" com valor 15
      - vari�vel "Z" com valor 30
      - vari�vel "R" com a conta "E" multiplicando "Z" e depois subtraia por "H"
Fa�a com a vari�vel resultado assuma o valor do bloco , sendo que na fun��o EVAL() deve passar o nItem no segundo par�metro
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
