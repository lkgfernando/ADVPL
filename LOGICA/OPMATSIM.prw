#Include 'Totvs.ch'



/*
+============================================================================================================+
| Fun��o: [ OPERA��O SIMPLES DE MATEMATICA ]                                                                 |
| Fun��o: [ OPMATSIM ]                                                                                       |
| Autor:  [ FERNANDO JOSE RODRIGUES ]                                                                        |
| Data Criacao: [ 01/03/2022 ]                                                                               |
| �ltima Altera��o: [  ]                                                                                     |
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
