#Include "Protheus.ch"

/*##############################################################################
| CALCULA DESCONTO EM SALÁRIO
|###############################################################################
*/
User Function AULA34(nSalario)
Local nDesconto := 0

if nSalario > 12000 .And. nSalario < 20000
    nDesconto := nSalario * 0.10
ElseIf nSalario >= 20000 .And. nSalario < 40000
    nDesconto := nSalario * 0.15
ElseIf nSalario >= 40000 .And. nSalario < 60000
    nDesconto := nSalario * 0.20
else
    nDesconto := nSalario * 0.50
endif

Return MsgInfo(cValToChar(nDesconto), "Total do Desconto:")
