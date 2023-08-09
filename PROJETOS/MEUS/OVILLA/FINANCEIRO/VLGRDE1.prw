#Include "Totvs.ch"
#Include "FWMVCDef.ch"


Static cTitulo := "Grupo DRE"
Static cTabZDD := "ZDD"


/*/{Protheus.doc} User Function VLGRDE1
    (RDMake para cadastro do grupo para o DRE)
    @type  Function
    @author Fernando Rodrigues
    @since 08/08/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function VLGRDE1()
    Local aArea := FWGetArea()
    Local oBrowse
    Private aRotina :={}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cTabZDD)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetails()
    oBrowse:AddLegend("ZDD_TIPO == '1'","BR_AZUL_CLARO", "Receita")
    oBrowse:AddLegend("ZDD_TIPO == '2'","BR_VIOLETA", "Despesa")

    oBrowse:Activate()

    FWRestArea(aArea)

Return Nil


/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 08/08/2023
    @version 1.0
    @param , , 
    @return aRotina, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.VLGRDE1" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.VLGRDE1" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.VLGRDE1" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.VLGRDE1" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 08/08/2023
    @version 1.0
    @param , , 
    @return oModel, ,           
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ModelDef()
    Local oStruct := FWFormStruct(1, cTabZDD)
    Local oModel
    Local bPre := Nil
    Local bPos := Nil
    Local bCommit := Nil
    Local bCancel := Nil

    oModel := MPFormModel():New("VLGRDE1M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("ZDDMASTER", /*cOwner*/, oStruct)
    oModel:SetDescription("Modelo de dados" + cTitulo)
    oModel:GetModel("ZDDMASTER"):SetDescription("Dados de " + cTitulo)
    oModel:SetPrimaryKey({})

Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 08/08/2023
    @version 1.0
    @param , , 
    @return oView, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("VLGRDE1")
    Local oStruct := FWFormStruct(2, cTabZDD)
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_ZDD", oStruct, "ZDDMASTER")
    oView:CreateHorizontalBox("TELA", 100)
    oView:SetOwnerView("VIEW_ZDD", "TELA")

Return oView
