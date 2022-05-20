#Include "Protheus.ch"

/*
|==========================================================================
|   EXEMPLO DE REPETIÇÃO COM WHILE / ENDDO dddddm                          |
|==========================================================================
*/


User Function AULA51(n1)
Local nCount := n1

while nCount <= 10
    MsgInfo("Essa repetição é de numero ==> " + cValToChar(nCount), "WHILE / ENDDO")
    nCount += 1
enddo

MsgInfo("Fim da repetição ela repetiu: " + cValToChar(nCount), "FIM!!")
    
Return
