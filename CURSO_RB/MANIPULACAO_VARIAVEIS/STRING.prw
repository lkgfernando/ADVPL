#INCLUDE "PROTHEUS.CH"


/*
// ##############################################################################################
// Projeto: Manipula��o de strings
// Modulo : SIGAATF
// Fonte  : zString
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 17/06/2022   | Fernando Rodrigues   | Apenas para estudos
// -------------+----------------------+---------------------------------------------------------*/


User Function zString()
    LOCAL nNumero := 10.5
    LOCAL cNumero := ""
    LOCAL dDate   :=  cTod("01/12/21")
    LOCAL cDate
    LOCAL sDate
    LOCAL cTexto  := "AULA PRATICA"
    LOCAL cTexto2
    LOCAL cTitle := "Manipula��o de String"

    cDate := DToC(dDate)
    sDate := DtoS(dDate)

    MsgAlert(cDate + " " + CValToChar(sDate), "Manipula��o de String")

    cNumero := Str(nNumero)
    MsgInfo(cNumero, "Manipula��o de String")

    cTexto2 := SubStr(cTexto, 1, 5)
    MsgInfo(cTexto2, "Manipula��o de String")

    cTexto2 := Capital(cTexto)
    MsgInfo(cTexto2, cTitle)

    cTexto2 := Lower(cTexto)
    MsgInfo(cTexto2, cTitle)

    cTexto2 := StrTran(Upper(cTexto), "A", "O")
    MsgInfo(cTexto2, cTitle)

    

   

    



Return
