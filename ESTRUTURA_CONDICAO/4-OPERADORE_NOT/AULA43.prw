#Include 'Protheus.ch'

/*
|---------------------------------------------------------------------------------
|
|   CONDI��O DE AUTORIZA��O OPERADOR .NOT. REPRESENTADO POR !
|   VERIFICAR SE O GERENTE AUTORIZA A LIVBERA��O MAS QUEM TEM A PALAVRA FINAL
|   � O DIRETOR DA EMPRESA.
|
|---------------------------------------------------------------------------------
*/

User Function AULA43()
Local lDecisao := .T.

if (lDecisao = .T.)
    MsgAlert("Foi Autorizado " + CValToChar(lDecisao), "GERENTE")
else
    MsgAlert("N�o foi Autorizado " + CValToChar(lDecisao), "GERENTE")
endif

lDecisao := !lDecisao // Diretor da empresa mudou a decis�o

if (lDecisao = .T.)
    MsgAlert("Foi Autorizado " + cValToChar(lDecisao), "DIRETOR")
else
    MsgAlert("N�o foi Autorizado " + cValToChar(lDecisao), "DIRETOR")
endif

Return 
