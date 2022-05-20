#Include "Protheus.ch"

/*/
|############################################################################
| COMPARAÇÕES PARA LOCALIZAR UM NUMERO MAIOR
|############################################################################
/*/

User Function AULA37(nNum1, nNum2, nNum3, nNum4 )
Local nNumero1 := nNum1
Local nNumero2 := nNum2
Local nNumero3 := nNum3
Local nNumero4 := nNum4

if (nNumero1 > nNumero2) .And. (nNumero1 > nNumero3) .And. (nNumero1 > nNumero4)
    MsgInfo(cValToChar(nNumero1) + " é o maior numero", "O Maior Numero")
elseif (nNumero2 > nNumero1) .And. (nNumero2 > nNumero3) .And. (nNumero2 > nNumero4)
    MsgInfo(cValToChar(nNumero2) + " é o maior numero", "O Maior Numero")
elseif (nNumero3 > nNumero1) .And. (nNumero3 > nNumero2) .And. (nNumero3 > nNumero4)
    MsgInfo(cValToChar(nNumero3) + " é o maior numero", "O Maior Numero")
elseif (nNumero4 > nNumero1) .And. (nNumero4 > nNumero2) .And. (nNumero4 > nNumero3)
    MsgInfo(cValToChar(nNumero4) + " é o maior numero", "O Maior Numero")
else
    MsgAlert("Exitem numeros maiores iguais", "!!! ATENÇÃO !!!!")    
endif

Return
