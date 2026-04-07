#Include "Protheus.ch"

/*###############################################################################
|   PROBLEMA DO EXERCIO COM OPERADOR .AND.
|################################################################################
*/
User Function AULA35()
Local lDiaEnsolarado := .T.
Local lMeuCarroOK := .T.

if (lDiaEnsolarado = .T. .And. lMeuCarroOK = .T.)
    MsgInfo("Hoje vai dar PRAIA")
else
    MsgInfo("Hoje é dia de NetFlix")
endif    

Return

