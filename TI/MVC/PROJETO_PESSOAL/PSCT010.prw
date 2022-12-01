#Include "Totvs.ch"
#Include "FWMVCDef.ch"


Static cTitulo := "Cotação de frete"
Static cCabCot := "ZC1"
Static cGrdCot := "ZC2"

/*/{Protheus.doc} User Function PSCT010
    (long_description)
    @type  Function
    @author FERNANDO RODRIGUES
    @since 29/11/2022
    /*/
User Function PSCT010()
    Local aArea := GetArea()
    Local oBrowse
    Private aRotina := {}
    
    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cCabCot)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetails()

    oBrowse:Activate()

    RestArea(aArea)

Return Nil


/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 29/11/2022
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.PSCT010" OPERATION 1 ACCESS 0 
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.PSCT010" OPERATION 3 ACCESS 0 
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.PSCT010" OPERATION 4 ACCESS 0 
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.PSCT010" OPERATION 5 ACCESS 0 

Return aRotina 

/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 29/11/2022
/*/
Static Function ModelDef()
    Local oStruZC1  := FWFormStruct(1, cCabCot)
    Local oStruZC2  := FWFormStruct(1, cGrdCot)
    Local oModel
    Local aRelation := {}
    Local bPre      := Nil
    Local bPos      := Nil
    Local bCommit   := Nil
    Local bCancel   := Nil

    oModel := MPFormModel():New("PSCT010M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("ZC1MASTER", /*cOwner*/, oStruZC1)
    oModel:AddGrid("ZC2DETAIL", "ZC1MASTER", oStruZC2)
    oModel:SetDescription("Modelo de dados - " + cTitulo)
    oModel:GetModel("ZC1MASTER"):SetDescription("Dados de - " + cTitulo)
    oModel:GetModel("ZC2DETAIL"):SetDescription("Grid de - " + cTitulo)
    oModel:GetModel("ZC2DETAIL"):SetOptional(.T.)
    oModel:SetPrimaryKey({})

    aAdd(aRelation, {"ZC2_FILIAL", "FWxFilial('ZC2')"})
    aAdd(aRelation, {"ZC2_PEDIDO", "ZC1_PEDIDO"})
    oModel:SetRelation("ZC2DETAIL", aRelation, ZC2->(IndexKey(1)))

    oModel:GetModel("ZC2DETAIL"):SetUniqueLine({'ZC2_CODTRA'})


Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 29/11/2022
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("PSCT010")
    Local oStruZC1 := FWFormStruct(2, cCabCot)
    Local oStruZC2 := FWFormStruct(2, cGrdCot)
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_ZC1", oStruZC1, "ZC1MASTER")
    oView:AddGrid("VIEW_ZC2", oStruZC2, "ZC2DETAIL")

    oView:CreateHorizontalBox("ZC1", 40)
    oView:CreateHorizontalBox("ZC2", 60)
    oView:SetOwnerView("VIEW_ZC1", "ZC1")
    oView:SetOwnerView("VIEW_ZC2", "ZC2")

    oView:EnableTitleView("VIEW_ZC1", "Cotação de Frete")
    oView:EnableTitleview("VIEW_ZC2", "Valores Transportadoras")

    oStruZC2:RemoveField("ZC2_PEDIDO")
    
Return oView 
