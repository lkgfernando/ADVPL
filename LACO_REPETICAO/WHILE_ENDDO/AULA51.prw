#Include "Protheus.ch"

/*
|==========================================================================
|   EXEMPLO DE REPETI��O COM WHILE / ENDDO dddddm                          |
|==========================================================================
*/


User Function AULA51(n1)
Local nCount := n1

while nCount <= 10
    MsgInfo("Essa repeti��o � de numero ==> " + cValToChar(nCount), "WHILE / ENDDO")
    nCount += 1
enddo

MsgInfo("Fim da repeti��o ela repetiu: " + cValToChar(nCount), "FIM!!")
    
Return
