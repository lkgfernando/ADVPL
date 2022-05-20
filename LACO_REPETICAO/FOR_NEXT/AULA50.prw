#Include "Protheus.ch"

/*
|======================================================================
|   EXEMPOLO DE FUNCIONAMENTO DO FOR NEXT
|======================================================================
*/
User Function AULA50(nVolta)
Local nNumVolt := nVolta
Local nContVol := 0

FOR nContVol := 1 TO nNumVolt
    MsgInfo("Está é a volta de numero ==> " + CValToChar(nContVol), "Estrutura For/Next!!")
NEXT nContVol

MsgInfo("Termino do laço de repetição", "FIM")
Return
