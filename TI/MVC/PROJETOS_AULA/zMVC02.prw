#Include "Totvs.ch"
#Include "FWMVCDef.ch"

Static cTitulo := "Cadastro CD'S"
Static cTabPai := "ZD2"
Static cTabFilho := "ZD3"


/*/{Protheus.doc} User Function zMVC02
    (long_description)
    @type  Function
    @author Fernado Rodrigues
    @since 25/11/2022
    /*/
User Function zMVC02()
    Local aArea := GetArea()
    Local oBrowse
    Private aRotina := {}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cTabPai)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetails()
    oBrowse:DisableDetails()
   

    oBrowse:Activate()

    RestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 25/11/2022
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC02" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC02" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC02" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC02" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rorigues
    @since 25/11/2022
/*/
Static Function ModelDef()
    Local oStruPai := FWFormStruct(1, cTabPai)
    Local oStruFilho := FWFormStruct(1, cTabFilho)
    Local aRelation := {}
    Local oModel
    Local bPre := Nil
    Local bPos := Nil
    Local bCommit := Nil
    Local bCancel := Nil

    oModel := MPFormModel():New("zMVC02M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("ZD2MASTER", /*cOwner*/, oStruPai)
    oModel:AddGrid("ZD3DETAIL", "ZD2MASTER", oStruFilho)
    oModel:SetDescription("Modelo de dados - " + cTitulo)
    oModel:GetModel("ZD2MASTER"):SetDescription("Dados de - " + cTitulo)
    oModel:GetModel("ZD3DETAIL"):SetDescription("Grid de - " + cTitulo)
    oModel:SetPrimaryKey({})

    //Relacionamento
    aAdd(aRelation, {"ZD3_FILIAL", "FWxFilial('ZD3')"} )
    aAdd(aRelation, {"ZD3_CD", "ZD2_CD"})
    oModel:SetRelation("ZD3DETAIL", aRelation, ZD3->(IndexKey(1)))

    //Definindo item unico na Grid
    oModel:GetModel("ZD3DETAIL"):SetUniqueLine({'ZD3_MUSICA'})

Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 25/11/2022
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("zMVC02")
    Local oStruPai := FWFormStruct(2, cTabPai)
    Local oStruFilho := FWFormStruct(2, cTabFilho)
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_ZD2", oStruPai, "ZD2MASTER")
    oView:AddGrid("VIEW_ZD3", oStruFilho, "ZD3DETAIL")

    //Alocar parte da tela
    oView:CreateHorizontalBox("CABEC", 30)
    oView:CreateHorizontalBox("GRID", 70)
    oView:SetOwnerView("VIEW_ZD2", "CABEC")
    oView:SetOwnerView("VIEW_ZD3", "GRID")

    oView:EnableTitleView("VIEW_ZD2", "Cabecalho - ZD2 (CDs)")
    oView:EnableTitleView("VIEW_ZD3", "Grid - ZD3 (Musicas dos CDs)")

    oStruFilho:RemoveField("ZD3_CD")

    oView:AddIncrementField("VIEW_ZD3", "ZD3_ITEM")

Return oView
