#Include 'Totvs.ch'



/*
+============================================================================================================+
| Função: [ OPERAÇÃO SIMPLES DE MATEMATICA ]                                                                 |
| Função: [ OPMATSIM ]                                                                                       |
| Autor:  [ FERNANDO JOSE RODRIGUES ]                                                                        |
| Data Criacao: [ 01/03/2022 ]                                                                               |
| Última Alteração: [  ]                                                                                     |
+============================================================================================================+
*/


User Function OPMATSIM()
	Local nSalario := 3300
    Local nDesconto := 0 
    Local nAumento := 0
    Local nSalLiq := 0

    nAumento := nSalario * 1.20
    nSalLiq := nAumento * (1 - nDesconto)

    MsgInfo("Salario Liquido: R$" + cValToChar(nSalLiq), "CALCULA SALARIO")

Return
