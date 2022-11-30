#Include "Totvs.ch"
#Include "FWMVCDef.ch"


Static cTitulo := "Fluxo de caixa diário"
Static cZV2    := "ZV2"
Static cZV3    := "ZV3"


/*/{Protheus.doc} VLFXCX1
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 28/11/2022
    @version 1.0
/*/
User Function VLFXCX1()
    Local aArea     := GetArea()
    Local oBrowse
    Private aRotina := {}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cZV2)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetails()

    oBrowse:Activate()

    RestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 28/11/2022
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.VLFXCX1" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.VLFXCX1" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.VLFXCX1" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.VLFXCX1" OPERATION 5 ACCESS 0

Return aRotina


/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 28/11/2022
/*/
Static Function ModelDef()
    Local oStruZV2  := FWFormStruct(1, cZV2)
    Local oStruZV3  := FWFormStruct(1, cZV3)
    Local aRelation := {}
    Local oModel
    Local bPre      := Nil
    Local bPos      := Nil
    Local bCommit   := Nil
    Local bCancel   := Nil
    
    oModel := MPFormModel():New("VLFXCX1M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("ZV2MASTER", /*cOwner*/, oStruZV2)
    oModel:AddGrid("ZV3VEND", "ZV2MASTER", oStruZV3)
    oModel:SetDescription("Modelo de dados - " + cTitulo)
    oModel:GetModel("ZV2MASTER"):SetDescription("Dados de " + cTitulo)
    oModel:GetModel("ZV3VEND"):SetDescription("Vendas de " + cTitulo)
    oModel:SetPrimaryKey({})

    aAdd(aRelation, {"ZV3_FILIAL", "FWxFilial('ZV3')"})
    aAdd(aRelation, {"ZV3_CAIXA", "ZV2_CAIXA"})
    oModel:SetRelation("ZV3VEND", aRelation, ZV3->(IndexKey(1)))

Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 28/11/2022
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("VLFXCX1")
    Local oStruZV2 := FWFormStruct(2, cZV2)
    Local oStruZV3 := FWFormStruct(2, cZV3)
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_ZV2", oStruZV2, "ZV2MASTER")
    oView:AddGrid("VIEW_ZV3", oStruZV3, "ZV3VEND")

    oView:CreateHorizontalBox("CABEC", 30)
    oView:CreateHorizontalBox("VEND", 70)
    oView:SetOwnerView("VIEW_ZV2", "CABEC")
    oView:SetOwnerView("VIEW_ZV3", "VEND")

    oView:EnableTitleView("VIEW_ZV2", "Fluxo de Caixa Diário")
    oView:EnableTitleView("VIEW_ZV3", "Vendas Diárias")

    oStruZV3:RemoveField("ZV3_CAIXA")

    oView:AddIncrementField("VIEW_ZV3", "ZV3_ITEM")

Return oView
