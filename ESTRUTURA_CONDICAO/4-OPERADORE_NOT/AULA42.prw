#Include "Protheus.ch"


/*
|###########################################################################
| FUNCIONAMENTO DA NEGAÇÃO NOT REPRESENTADO PELO !
|###########################################################################
*/
User Function AULA42()
Local lStatus := .T.

MsgInfo("Variavel lStatus sem tratamento de negação" + cValTochar(lStatus), "Primeiro")

lStatus := !lStatus 

MsgAlert("Varivael lstatus tratamento de negação" + cValTochar(lStatus), "Segundo")
Return
