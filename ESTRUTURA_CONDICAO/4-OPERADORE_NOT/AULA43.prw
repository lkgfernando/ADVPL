#Include 'Protheus.ch'

/*
|---------------------------------------------------------------------------------
|
|   CONDIÇÃO DE AUTORIZAÇÃO OPERADOR .NOT. REPRESENTADO POR !
|   VERIFICAR SE O GERENTE AUTORIZA A LIVBERAÇÃO MAS QUEM TEM A PALAVRA FINAL
|   É O DIRETOR DA EMPRESA.
|
|---------------------------------------------------------------------------------
*/

User Function AULA43()
Local lDecisao := .T.

if (lDecisao = .T.)
    MsgAlert("Foi Autorizado " + CValToChar(lDecisao), "GERENTE")
else
    MsgAlert("Não foi Autorizado " + CValToChar(lDecisao), "GERENTE")
endif

lDecisao := !lDecisao // Diretor da empresa mudou a decisão

if (lDecisao = .T.)
    MsgAlert("Foi Autorizado " + cValToChar(lDecisao), "DIRETOR")
else
    MsgAlert("Não foi Autorizado " + cValToChar(lDecisao), "DIRETOR")
endif

Return 
