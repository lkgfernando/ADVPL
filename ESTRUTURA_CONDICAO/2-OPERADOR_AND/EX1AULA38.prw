#Include "Protheus.ch"

/*/
|####################################################################
| CALCULA DE MÉDIA ARITIMÉTICA DE NOTA
|####################################################################
/*/

User Function EX1AULA38(n1,n2,n3,n4)
Local nNota1 := n1
Local nNota2 := n2
Local nNota3 := n3
Local nNota4 := n4
Local nMedia := 0

nMedia := (nNota1 + nNota2 + nNota3 + nNota4) / 4

if nMedia >= 7
    MsgInfo("Sua nota foi ==> " + cValToChar(nMedia) + " APROVADO", "CALCULA MÉDIA")
else
    MsgInfo("Sua nota foi ==> " + cValToChar(nMedia) + " REPROVADO", "CALCULA MÉDIA")
endif

Return
