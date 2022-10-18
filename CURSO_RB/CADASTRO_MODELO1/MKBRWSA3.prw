#Include "Totvs.ch"


/*/{Protheus.doc} User Function MkBrwSA3
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 17/10/2022
    /*/
User Function MkBrwSA3()
    Local aArea := GetArea()
    Local aCpos := {}
    Local aCampos := {}
    Local nI := 0
    Local cAlias := "SA3"
    Private aRotina := {}
    Private cCadastro := "Cadastro de Vendedores"
    Private aRecSel := {}

    AADD(aRotina, {"Visuarlizar Lote", "U_VisVend", 0, 5})

    AADD(aCpos, "A3_ZOK")
    AADD(aCpos, "A3_COD")
    AADD(aCpos, "A3_NOME")
    AADD(aCpos, "A3_NREDUZ")
    AADD(aCpos, "A3_TIPVEND")

    DbSelectArea("SX3")
    DbSetOrder(2)

    For nI := 1 To Len(aCpos)
        If DbSeek(aCpos[nI])
            AADD(aCampos,{X3_CAMPO,"" ,IIF(nI == 1, "", Trim(X3_TITULO)), Trim(X3_PICTURE)})
        EndIf
    Next nI

    DbSelectArea(cAlias)
    DbSetOrder(1)
    MarkBrow(cAlias, aCpos[1], "A3_TIPVEND = '2'", aCampos, .F., GetMark("SA3","A3_ZOK"))
  

    RestArea(aArea)
Return

/*/{Protheus.doc} User VisVend
    (long_description)
    @type  Function
    @author Fernando Jose Rodrigues
    @since 18/10/2022
    /*/
User Function VisVend()
    Local cMark := ThisMark()
    Local nX := 0
    Local lInvert := ThisInv()
    Local cTexto := ""
    Local oDlg
    Local oMemo

    DbSelectArea("SA3")
    DbSetOrder(1)
    DbGoTop()

    While !Eof()
        If SA3->A3_ZOK == cMark .And. !lInvert
            AADD(aRecSel,{SA3->(Recno()),SA3->A3_COD, SA3->A3_NOME, SA3->A3_NREDUZ })
        ElseIf SA3->A3_ZOK != cMarca .And. lInver
            AADD(aRecSel,{SA3->(Recno()),SA3->A3_COD, SA3->A3_NOME, SA3->A3_NREDUZ })
        EndIf
        DbSkip()
    EndDo

    If Len(aRecSel) > 0
        cTexto := "Codigo  |  Nome                 |  Nome Reduzido" + CRLF
                                
        For nX := 1 To Len(aRecSel)
            cTexto += aRecSel[nX][2] + Space(2) +"|"+ Space(2) + SubString(aRecSel[nX][3], 1, 20) + Space(3) + "|"  
            cTexto += Space(2) + SubString(aRecSel[nX][4],1 ,20) + Space(2)
            cTexto += +CRLF

        Next nX

        DEFINE MSDIALOG oDlg TITLE "Cadastro de Vendedores" FROM 000,000 TO 350,400 PIXEL
        @ 005,005 GET oMemo VAR cTexto MEMO SIZE 150,150 OF oDlg PIXEL
        oMemo:bRClicked := {||AllWaysTrue()} 
        DEFINE SBUTTON FROM 005,165 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL
        ACTIVATE MSDIALOG oDlg CENTERED 
        LimpaMarca()
    EndIf
Return

/*/{Protheus.doc} LimpaMarca
    (long_description)
    @type  Static Function
    @author Fernando Jose Rodrigues
    @since 18/10/2022
/*/
Static Function LimpaMarca()
    Local nX := 0

    For nX := 1 To Len(aRecSel)
        SA3->(DbGoTo(aRecSel[nX][1]))
        RecLock("SA3", .F.)
        SA3->A3_ZOK := Space(2)            
        MsUnlock()
    Next nX
Return 
