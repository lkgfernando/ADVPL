#Include "Totvs.ch"


/*/{Protheus.doc} User Function zOO05
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 06/03/2023
    @version 1.0
    @param , ,
    @return , ,
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zOO05()
    Local aArea := FWGetArea()

    fMontaTela()

    FWRestArea(aArea)
Return


/*/{Protheus.doc} fMontaTela
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/03/2023
    @version 1.0
    @param , ,
    @return , ,
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fMontaTela()
    Local nLargBtn                 := 50
    //Objetos e componentes
    Private oPanGrid
    Private oDlgPulo
    //Cabeçalho
    Private oSayModulo, cSayModulo := 'TST'
    Private oSayTitulo, cSAyTitulo := 'Pulo do Gato na Montagem de Dialogs'
    Private oSaySubTit, cSaySubTit := 'Exemplo usando Matemática'
    //Tamanho da janela
    Private aSize                  := MsAdvSize(.F.)
    Private nJanLarg               := aSize[5]
    Private nJanAltu               := aSize[6]
    //Fontes
    Private cFontUti               := "Tahoma"
    Private oFontMod               := TFont():New(cFontUti, , -38)
    Private oFontSub               := TFont():New(cFontUti, , -20)
    Private oFontSubN              := TFont():New(cFontUti, , - 20, .T.)
    Private oFontBtn               := TFont():New(cFontUti, , -20)
    Private oFontSay               := TFont():New(cFontUti, , -12)
    //Grid
    Private aCampos                := {}
    Private cAliasTmp              := "TST_" + RetCodUsr()
    Private aColunas               := {}

    aadd(aCampos, {"CODIGO", "C", TamSX3("BM_GRUPO")[1], 0})
    aadd(aCampos, {"DESCRI", "C", TamSX3("BM_DESC")[1] , 0})

    //Criando tabela temporaria
    oTempTable := FWTemporaryTable():New(cAliasTmp)
    oTempTable:SetFields( aCampos )
    oTempTable:Create()
    //Busca a coluna no browse
    aColunas := fCriaCols()

    //Popula tabela temporaria
    Processa({|| fPopula()}, "Processando...")

    //Cria a Janela
    DEFINE MSDIALOG oDlgPulo TITLE "Exempo de Pulo do Gato" FROM 0, 0 TO nJanAltu, nJanLarg PIXEL

        //Titulos e subtitulos
        oSayModulo := TSay():New(004, 003, {|| cSayModulo}, oDlgPulo, "", oFontMod,  , , , .T., RGB(149, 179, 215), , 200, 30, , , , , , .F., , )
        oSayTitulo := TSay():New(004, 045, {|| cSayTitulo}, oDlgPulo, "", oFontSub,  , , , .T., RGB(031, 073, 125), , 200, 30, , , , , , .F., , )
        oSaySubtit := TSay():New(014, 045, {|| cSaySubTit}, oDlgPulo, "", oFontSubN, , , , .T., RGB(031, 073, 125), , 300, 30, , , , , , .F., , )

        //Criando os botões
        oBtnSair := TButton():New(006, (nJanLarg / 2 - 001) - ((nLargBtn + 2) * 1) , "Fechar", oDlgPulo, {|| oDlgPulo:End()}, nLargBtn, 018, , oFontBtn, , .T., , , , , , )
       
       

        //Cria grid
        oPanGrid := tPanel():New(027, 001, "", oDlgPulo, , , , RGB(000, 000, 000), RGB(254, 254, 254), (nJanLarg/2) - 1 , (nJanAltu/2) - 3)
        oGetGrid := FWBrowse():New()
        oGetGrid:SetDataTable()
        oGetGrid:SetInsert(.F.)
        oGetGrid:SetDelete(.F., {|| .F. })
        oGetGrid:SetAlias(cAliasTmp)
        oGetGrid:DisableReport()
        oGetGrid:DisableFilter()
        oGetGrid:DisableConfig()
        oGetGrid:DisableReport()
        oGetGrid:DisableSeek()
        oGetGrid:DisableSaveConfig()
        oGetGrid:SetFontBrowse(oFontSay)
        oGetGrid:SetColumns(aColunas)
        oGetGrid:SetOwner(oPanGrid)
        oGetGrid:Activate()
    Activate MsDialog oDlgPulo Centered
    oTempTable:Delete()

Return

/*/{Protheus.doc} fCriaCols
    (long_description)
    @type  Static Function
    @author Fernando Jose Rodrigues
    @since 07/03/2023
    @version 1.0
    @param , ,
    @return , ,
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fCriaCols()
    Local nAtual   := 0
    Local aColunas := {}
    Local aEstruct := {}
    Local oColumn

    //Adicionando campos que serão mostrados na tela
    //[1] - Campo da Temporaria
    //[2] - Titulo
    //[3] - Tipo
    //[4] - Tamanho
    //[5] - Decimais
    //[6] - Máscara
    aAdd(aEstruct, {"CODIGO", "Código"   , "C", TamSx3( 'BM_GRUPO' )[01], 0, ""})
    aAdd(aEstruct, {"DESCRI", "Descrição", "C", TamSx3( 'BM_DESC' )[01] , 0, ""})

    For nAtual := 1 To Len(aEstruct)

        oColumn := FWBrwColumn():New()
        oColumn:SetData(&("{|| (cAliasTmp)->" + aEstruct[nAtual][1] + "}"))
        oColumn:SetTitle(aEstruct[nAtual][2])
        oColumn:SetType(aEstruct[nAtual][3])
        oColumn:SetSize(aEstruct[nAtual][4])
        oColumn:SetDecimal(aEstruct[nAtual][5])
        oColumn:SetPicture(aEstruct[nAtual][6])
        oColumn:bHeaderClick := &("{|| fOrdena('" + aEstruct[nAtual][1] + "') }")

        aAdd(aColunas, oColumn)

    Next

Return aColunas

/*/{Protheus.doc} fPopula
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 07/03/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fPopula()
    Local nAtual := 0
    Local nTotal := 0

    DbSelectArea("SBM")
    SBM->(DbSetOrder(1))
    SBM->(DbGoTop())

    Count To nTotal
    ProcRegua(nTotal)
    SBM->(DbGoTop())

    While ! SBM->(Eof())

        nAtual ++
        IncProc("Adicionando registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")

        RecLock(cAliasTmp, .T.)
            (cAliasTmp)->CODIGO :=  SBM->BM_GRUPO
            (cAliasTmp)->DESCRI :=  SBM->BM_DESC
        (cAliasTmp)->(MsUnlock())

        SBM->(DbSkip())
    EndDo
Return 
