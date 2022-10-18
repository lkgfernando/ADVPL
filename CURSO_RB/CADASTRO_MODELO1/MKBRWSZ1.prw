#Include "Totvs.ch"


/*/{Protheus.doc} User Function MkBrwSZ1
    (Cria um Mark Browse da SZ1 -> unidade de medida cliente)
    @type  Function
    @author Fernando José Rodrigues
    @since 17/10/2022
    /*/
User Function MkBrwSZ1()
    Local aArea := GetArea()
    Local aCpos := {}
    Local aCampos := {}
    Local nI := 0
    Local cAlias := "SZ1"
    Private aRotina := {}
    Private cCadastro := "Cadastro de UM por cliente"
    Private aRecSel := {}

    //Botoes
    AADD(aRotina, {"Visualizar Lote", "U_VisLote", 0, 5})

    //Campos do Browse
    AADD(aCpos, "Z1_OK")
    AADD(aCpos, "Z1_FILIAL")
    AADD(aCpos, "Z1_CLIENT")
    AADD(aCpos, "Z1_LOJA")
    AADD(aCpos, "Z1_PRODUT")
    AADD(aCpos, "Z1_FATOR")

    DbSelectArea("SX3")
    DbSetOrder(2)
    For nI := 1 To Len(aCpos)
        If DbSeek(aCpos[nI])
            AADD(aCampos, {X3_CAMPO, "", IIF(nI == 1, "", Trim(X3_TITULO)), Trim(X3_PICTURE)})
        EndIf
    Next nI

    DbSelectArea(cAlias)
    DbSetOrder(1)
    MarkBrow(cAlias, aCpos[1], "Z1_TIPO == ' '", aCampos, .F., GetMark(,"SZ1","Z1_OK"))

    RestArea(aArea)
Return Nil

/*/{Protheus.doc} User Function VisLote
    (Visualiza itens marcados em um MSDIALOG)
    @type  Function
    @author Fernando José Rodrigues
    @since 17/10/2022
    /*/
User Function VisLote()
    Local cMarca := ThisMark()
    Local nX := 0
    Local lInvert := ThisInv()
    Local cTexto := ""
    Local oDlg
    Local oMemo

    DbSelectArea("SZ1")
    DbSetOrder(1)
    DbGoTop()

    While !Eof()

        If SZ1->Z1_OK == cMarca .And. !lInvert
            AADD(aRecSel, {SZ1->(Recno()), SZ1->Z1_CLIENT, SZ1->Z1_LOJA, SZ1->Z1_PRODUT})
        ElseIf SZ1->Z1_OK != cMarca .And. lInvert
            AADD(aRecSel, {SZ1->(Recno()), SZ1->Z1_CLIENT, SZ1->Z1_LOJA, SZ1->Z1_PRODUT})
        EndIf
        DbSkip()
    EndDo

    If Len(aRecSel) > 0
        cTexto := "Cliente  |  Loja  | Cod.Produto" + CRLF

        For nX := 1 To Len(aRecSel)
            cTexto += aRecSel[nX][2] + Space(1) + "|" + Space(2) + aRecSel[nX][3] + Space(3) + "|"
            cTexto += Space(1) + SubString(aRecSel[nX][4], 1, 20) + Space(1) 
            cTexto += + CRLF
        Next nX

        DEFINE MSDIALOG oDlg TITLE "Clientes Selecionados" From 000,000 TO 350,400 PIXEL
        @ 005,005 GET oMemo VAR cTexto MEMO SIZE 150,150 OF oDlg PIXEL
        oMemo:bRClicked := {||AllwaysTrue()}
        DEFINE SBUTTON FROM 005,165 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL
        ACTIVATE MSDIALOG oDlg CENTERED
        LimpaMarca()
    EndIf
Return



/*/{Protheus.doc} LimpaMarca
    (Limpa o campo Z1_OK)
    @type  Static Function
    @author Fernando José Rodrigues
    @since 17/10/2022
/*/
Static Function LimpaMarca()
    Local nX := 0

    For nX := 1 To Len(aRecSel)
        SZ1->(DbGoto(aRecSel[nX][1]))
        RecLock("SZ1", .F.)
        SZ1->Z1_OK := Space(2)
        MsUnlock()
    Next nX
Return
