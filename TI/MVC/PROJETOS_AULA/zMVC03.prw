#Include "Totvs.ch"
#Include "FWMVCDef.ch"

Static cTitulo := "Artistas X CDs x Músicas"
Static cTabPai := "ZD1"
Static cTabFilho := "ZD2"
Static cTabNeto := "ZD3"


/*/{Protheus.doc} zMVC03
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 25/11/2022
    /*/
User Function zMVC03()
    Local aArea := GetArea()
    Local oBrowse
    Private aRotina := {}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cTabPai)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetails()

    oBrowse:Activate()

    RestArea(aArea)

Return Nil

/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 25/11/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC03" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Inserir" ACTION "VIEWDEF.zMVC03" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC03" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC03" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 25/11/2022
/*/
Static Function ModelDef()
    Local oStruPai   := FWFormStruct(1, cTabPai)
    Local oStruFilho := FWFormStruct(1, cTabFilho, { |x| ! AllTrim(x) $ 'ZD2_NOME'})
    Local oStruNeto  := FWFormStruct(1, cTabNeto)
    Local aRelFilho  := {}
    Local aRelNeto   := {}
    Local oModel
    Local bPre       := Nil
    Local bPos       := Nil
    Local bCommit    := Nil
    Local bCancel    := Nil

    oModel := MPFormModel():New("zMVC03M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("ZD1MASTER", /*cOwner*/, oStruPai)
    oModel:AddGrid("ZD2DETAIL", "ZD1MASTER", oStruFilho)
    oModel:AddGrid("ZD3DETAIL", "ZD2DETAIL", oStruNeto)
    oModel:SetPrimaryKey({})

    //Relacionamento (Pai e Filho)
    oStruFilho:SetProperty("ZD2_ARTIST", MODEL_FIELD_OBRIGAT, .F.)
    aAdd(aRelFilho, {"ZD2_FILIAL", " FWxFilial('ZD2')"})
    aAdd(aRelFilho, {"ZD2_ARTIST", "ZD1_CODIGO"})
    oModel:SetRelation("ZD2DETAIL", aRelFilho, ZD2->(IndexKey(1)))
    
    //Relacionamento (filho e neto)
    aAdd(aRelNeto, {"ZD3_FILIAL", "FWxFilial('ZD3')"} )
    aAdd(aRelNeto, {"ZD3_CD", "ZD2_CD"})
    oModel:SetRelation("ZD3DETAIL", aRelNeto, ZD3->(IndexKey(1)))

    //Definir campos unicos das grid
    oModel:GetModel("ZD2DETAIL"):SetUniqueLine({'ZD2_CD'})
    oModel:GetModel("ZD3DETAIL"):SetUniqueLine({'ZD3_MUSICA'})

Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 25/11/2022
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("zMVC03")
    Local oStruPai := FWFormStruct(2, cTabPai)
    Local oStruFilho := FWFormStruct(2, cTabFilho, { |x| ! AllTrim(x) $ 'ZD2_NOME'})
    Local oStruNeto := FWFormStruct(2, cTabNeto)
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_ZD1", oStruPai, "ZD1MASTER")
    oView:AddGrid("VIEW_ZD2", oStruFilho, "ZD2DETAIL")
    oView:AddGrid("VIEW_ZD3", oStruNeto, "ZD3DETAIL")

    oView:CreateHorizontalBox("CABEC_PAI", 30)
    oView:CreateHorizontalBox("GRID_FILHO", 30)
    oView:CreateHorizontalBox("GRID_NETO", 40)
    oView:SetOwnerView("VIEW_ZD1", "CABEC_PAI")
    oView:SetOwnerView("VIEW_ZD2", "GRID_FILHO")
    oView:SetOwnerView("VIEW_ZD3", "GRID_NETO")

    oView:EnableTitleView("VIEW_ZD1", "Pai - ZD1 (Artistas)")
    oView:EnableTitleView("VIEW_ZD2", "Filho - ZD2 (CDs)")
    oView:EnableTitleView("VIEW_ZD3", "Neto - ZD3 (Musicas dos CDs)")

    oStruFilho:RemoveField("ZD2_ARTIST")
    oStruFilho:RemoveField("ZD2_NOME")
    oStruNeto:RemoveField("ZD3_CD")

    oStruFilho:RemoveField("ZD2_ARTIST")
    oStruFilho:RemoveField("ZD2_NOME")
    oStruNeto:RemoveField("ZD3_CD")

    oView:AddIncrementField("VIEW_ZD3", "ZD3_ITEM")

Return oView
