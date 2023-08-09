#Include 'Totvs.ch'
#Include 'FWMVCDef.ch'

Static cTitulo   := "Cadastro Prato x Ingredientes"
Static cTabPai   := "SZ2"
Static cTabFilho := "SZ3"


/*/{Protheus.doc} User Function VLCAD01
    Cadastro de prato e a composição dos ingreditens
    @type  Function
    @author Fernando Rodrigues
    @since 06/08/2023
    @version 1.0
    @param , , 
    @return Nil, , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function VLCAD01()
    Local aArea := FWGetArea()
    Local oBrowse
    Private aRotina := {}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cTabPai)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetails()
    oBrowse:AddLegend("Z2_MSBLQL <> '2'", "RED", "Bloqueado")
    oBrowse:AddLegend("Z2_MSBLQL == '2'", "GREEN", "Ativo")

    oBrowse:Activate()

    FWRestArea(aArea)

Return Nil


/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/08/2023
    @version 1.0
    @param , , 
    @return aRotina, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.VLCAD01" OPERATION 1 ACCESS 0 
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.VLCAD01" OPERATION 3 ACCESS 0 
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.VLCAD01" OPERATION 4 ACCESS 0 
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.VLCAD01" OPERATION 5 ACCESS 0 

Return aRotina


/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/08/2023
    @version 1.0
    @param , , 
    @return oModel, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ModelDef()
    Local oStruPai   := FWFormStruct(1, cTabPai)
    Local oStruFilho := FWFormStruct(1, cTabFilho)
    Local aRelation  := {}
    Local oModel
    Local bPre       := Nil
    Local bPos       := Nil
    Local bCommit    := Nil
    Local bCancel    := Nil

    oModel := MPFormModel():New("VLCAD01M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("SZ2MASTER", /*cOwner*/, oStruPai)
    oModel:AddGrid("SZ3DETAIL", "SZ2MASTER", oStruFilho,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)
    oModel:SetDescription("Modelo de dados " + cTitulo)
    oModel:GetModel("SZ2MASTER"):SetDescription("Dados de - " + cTitulo)
    oModel:GetModel("SZ3DETAIL"):SetDescription("Grid de - " + cTitulo)
    oModel:SetPrimaryKey({})

    //Fazendo o Relacionamento
    aAdd(aRelation, {"Z3_FILIAL", "FWxFilial('SZ3')"})
    aAdd(aRelation, {"Z3_Z2COD", "Z2_CODPROD"})
    oModel:SetRelation("SZ3DETAIL", aRelation, SZ3->(IndexKey(1)))

    oModel:GetModel("SZ3DETAIL"):SetUniqueLine({'Z3_CODPRD'})

Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/08/2023
    @version 1.0
    @param , , 
    @return oView, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("VLCAD01")
    Local oStruPai := FWFormStruct(2, cTabPai)
    Local oStruFilho := FWFormStruct(2, cTabFilho)
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_SZ2", oStruPai, "SZ2MASTER")
    oView:AddGrid("VIEW_SZ3", oStruFilho, "SZ3DETAIL")

    oView:CreateHorizontalBox("CABEC", 30)
    oView:CreateHorizontalBox("GRID", 70)
    oView:SetOwnerView("VIEW_SZ2", "CABEC")
    oView:SetOwnerView("VIEW_SZ3", "GRID")

    oView:EnableTitleView("VIEW_SZ2", "Cabeçalho - SZ2 (Pratos)")
    oView:EnableTitleView("VIEW_SZ3", "Grid - SZ3 (Ingredientes)")

    oStruFilho:RemoveField("Z3_Z2COD")

    oView:AddIncrementField("VIEW_SZ3", "Z3_ITEM")

Return oView
