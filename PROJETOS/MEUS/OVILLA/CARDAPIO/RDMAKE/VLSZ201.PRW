#Include "Totvs.ch"
#Include "FWMVCDef.ch"


Static cTitulo  := "Cadastro de Cardapio"
Static cAlias   := "SZ2"



/*/{Protheus.doc} User Function VLSZ201
    (Criação do RDMAKE da tabela SZ2 cadastro de produtos no cardápio)
    @type  Function
    @author Fernando Rodrigues
    @since 31/07/2023
    @version 1.0
    @param , , 
    @return Nil, , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function VLSZ201()
    Local aArea     := FWGetArea()
    Local oBrowse
    Private aRotina   := {}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitulo)
    oBrowse:AddLegend("Z2_MSBLQL <> '2'", "RED", "Bloqueado")
    oBrowse:AddLegend("Z2_MSBLQL == '2'", "GREEN", "Ativo")

    oBrowse:Activate()
    
    FWRestArea(aArea)
Return Nil


/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 31/07/2023
    @version 1.0    
    @param , , 
    @return aRotina,
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function MenuDef()
    Local aRotina  := {}

    //ADD OPTION aRotina TITLE 'Pesquisar'    ACTION 'PesqBrw'            OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.VLSZ201'    OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.VLSZ201'    OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.VLSZ201'    OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.VLSZ201'    OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE 'Imprimir'     ACTION 'VIEWDEF.VLSZ201'    OPERATION 8 ACCESS 0
    ADD OPTION aRotina TITLE 'Copiar'       ACTION 'VIEWDEF.VLSZ201'    OPERATION 9 ACCESS 0

Return aRotina


/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 31/07/2023
    @version 1.0
    @param , , 
    @return oModel, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ModelDef()
    Local oStruSZ2 := FWFormStruct(1, cAlias)
    Local oModel
    Local bPre     := Nil
    Local bPos     := Nil //{|oMdl| MOD1CPOS(oMdl)}
    Local bCommit  := Nil
    Local bCancel  := Nil

    oModel := MpFormModel():New('VZSZ201M', bPre, bPos, bCommit, bCancel)
    oModel:AddFields('SZ2MASTER', /*cOwner*/, oStruSZ2)
    oModel:SetDescription("Modelo de dados " + cTitulo)
    oModel:GetModel('SZ2MASTER'):SetDescription('Dados - ' + cTitulo)
    oModel:SetPrimaryKey({'Z2_FILIAL','Z2_CODPROD'})

    
Return oModel


/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues 
    @since 31/07/2023
    @version 1.0
    @param , , 
    @return oView, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel('VLSZ201')
    Local oStruSZ2 := FWFormStruct(2, cAlias)
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField('VIEW_SZ1', oStruSZ2, 'SZ2MASTER')
    oView:CreateHorizontalBox('TELA', 100)
    oView:SetOwnerView('VIEW_SZ1', 'TELA')
    oView:SetCloseOnOk({|| .T.})

Return oView
