#Include "Totvs.ch"
#Include "TopConn.ch"
#Include "TbiConn.ch"


/*/{Protheus.doc} User Function zPopulaSZ1
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 22/05/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zPopulaSZ1()
    Local aArea    := FwGetArea()
    Local cQryZS1  := ""
    Local nNumSem  := 0
    Local nAno     := Year(Date())
    Local cDateIni := "01/01/" + cValToChar(nAno)
    Local dDateIni := cTod(cDateIni) 
    Local dDateFim := 0
    Local cAnoReg  := ""
    Local cNumReg  := ""


    If Dow(dDateIni) == 2
        dDateIni -= 1
    ElseIf Dow(dDateIni) == 3
        dDateIni -= 2
    ElseIf Dow(dDateIni) == 4
        dDateIni -= 3
    ElseIf DoW(dDateIni) == 5
        dDateIni -= 4
    ElseIf Dow(dDateIni) == 6
        dDateIni -= 5
    ElseIf Dow(dDateIni) == 7
        dDateIni -= 6
    EndIf



    cQryZS1 := " SELECT " + CRLF
    cQryZS1 += "    ZS1_COD, " + CRLF
    cQryZS1 += "    ZS1_ANO " + CRLF
    cQryZS1 += " FROM   " + RetSqlName('ZS1') + " " + CRLF
    cQryZS1 += " WHERE " + CRLF
    cQryZS1 += "    D_E_L_E_T_ <> '*' " + CRLF
    cQryZS1 += "    AND ZS1_ANO = '" + cValToChar(nAno) + "' " 

    //MemoWrite("SEQUENCIA_SEMANA.SQL", cQryZS1)

    TCQuery cQryZS1 ALIAS QRYZS1 NEW
  
    DbSelectArea(QRYZS1)
    DbGoTop()

    If QRYZS1->(Eof())

    DbSelectArea('ZS1')
    ZS1->(DbSetOrder(1))
    ZS1->(DbGoTop())
      
        While  nNumSem <= 52 //.And. ZS1->ZS1_ANO == cValToChar(nAno)
            dDateFim := dDateIni + 6
            nNumSem += 1
            RecLock("ZS1", .T.)
            ZS1->ZS1_COD := cValToChar(StrZero(nNumSem, 2))
            ZS1->ZS1_ANO := cValToChar(nAno)
            ZS1->ZS1_DATINI := dDateIni
            ZS1->ZS1_DATFIM := dDateFim
            ZS1->(MsUnlock())

            If nNumSem >= 1
                dDateIni := dDateFim + 1
            EndIf

            cNumReg := ZS1->ZS1_COD
            cAnoReg := ZS1->ZS1_ANO


            DbSelectArea('ZS1')
            DbSkip()

        EndDo

    EndIf

    ZS1->(DbCloseArea())
    DbSelectArea(QRYZS1)
    DbCloseArea()

    FWRestArea(aArea)
Return 
