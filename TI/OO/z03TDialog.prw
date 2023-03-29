#Include "Totvs.ch"

/*/{Protheus.doc} User Function z03TDialo
    (Referente ao exercico do terminal de informação zOO03)
    @type  Function
    @author Fernando Rodrigues
    @since 02/03/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function z03TDialo()
    Local aArea := FwGetArea()
    
    fDialogMs()
    fDialogT()
    fDialogFW()

    FWRestArea(aArea)
Return

/*/{Protheus.doc} fDialogMs
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 02/03/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fDialogMs()
    Local oDlgAux
    Local nJanAlTu   := 200
    Local nJanLarg   := 400
    Local cJanTitulo := "Tela usando MsDialog"

    //Criando a janela
    DEFINE MSDIALOG oDlgAux TITLE cJanTitulo FROM 000, 000 TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL

    //Ativanda a janela
    ACTIVATE MSDIALOG oDlgAux CENTERED
    
Return 

/*/{Protheus.doc} fDialogT
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 02/03/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fDialogT()
    Local oDlgAux
    Local nJanAltu := 200
    Local nJanLarg := 400
    Local lDimPixels := .T.
    Local lCentraliz := .T.
    Local bBlocoIni := {||}
    Local cJanTitulo := "Tela usando TDialog"

    oDlgAux := TDialog():New(0, 0, nJanAltu, nJanLarg, cJanTitulo, , , , , , /*nCorFundo*/, , , lDimPixels)

    oDlgAux:Activate(, , , lCentraliz, , , bBlocoIni)

Return 


/*/{Protheus.doc} fDialogFW
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 02/03/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fDialogFW()
    Local oDlgAux
    Local nJanAltu   := 100
    Local nJanLarg   := 200
    Local bBlocoTst  :={|| FWAlertInfo("Clicou no botão escrito 'Teste' ", "Botão Teste")}
    Local cJanTitulo := "Tela usando FWDialoModal"

    //Instancia a classe, criando uma janela
    oDlgAux := FWDialogModal():New()
    oDlgAux:SetTitle(cJanTitulo)
    oDlgAux:SetSize(nJanAltu, nJanLarg)
    oDlgAux:EnableFormBar(.T.)
    oDlgAux:CreateDialog()
    oDlgAux:CreateFormBar()
    oDlgAux:AddButton("Teste", bBlocoTst, "Teste", , .T., .F., .T.,)
    //Aqui antes de abrir a tela, caso queira usar essa classe, pode usar o método oDlgAux:GetPanelMain()
    // e intacia os objetos apontando para esse painel
    oDlgAux:GetPanelMain()

    oDlgAux:Activate()
    
Return 
