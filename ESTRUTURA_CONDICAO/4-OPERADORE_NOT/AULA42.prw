#Include "Protheus.ch"


/*
|###########################################################################
| FUNCIONAMENTO DA NEGA��O NOT REPRESENTADO PELO !
|###########################################################################
*/
User Function AULA42()
Local lStatus := .T.

MsgInfo("Variavel lStatus sem tratamento de nega��o" + cValTochar(lStatus), "Primeiro")

lStatus := !lStatus 

MsgAlert("Varivael lstatus tratamento de nega��o" + cValTochar(lStatus), "Segundo")
Return
