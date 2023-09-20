#Include "Totvs.ch"
#Include "FwMVCDef.ch"


Static cTitulo   := "Artista X CDs X Musicas"
Static cTabPai   := "ZD1"
Static cTabFilho := "ZD2"
Static cTabNeto  := "ZD3"


/*/{Protheus.doc} User Function zMVC08
    (long_description)
    @type Function
    @author Fernando Rodrigues
    @since 09/12/2022
/*/
User Function zMVC08()
    Local aArea      := FWGetArea()
    Local oBrowse
    Private aRotina  := {}

    aRotina          := MenuDef()

    oBrowse          := FWMBrowse()  :New()
    oBrowse:SetAlias(cTabPai)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetail()

    oBrowse:Activate()

    FWRestArea(aArea)
Return Nil

/*/                                                                              {Protheus.doc} MenuDef
    (long_description)
    @type Static Function
    @author Fernando Rodrigues
    @since 09/12/2022
/*/
Static Function MenuDef()
    Local aRotina    := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC08" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC08" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC08" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC08" OPERATION 5 ACCESS 0

Return aRotina

/*/                                                                              {Protheus.doc} ModelDef
    (long_description)
    @type Static Function
    @author Fernando Rodrigues
    @since 09/12/2022
/*/
Static Function ModelDef()
    Local oStruPai   := FWFormStruct(1, cTabPai)
    Local oStruFilho := FWFormStruct(1, cTabFilho, { |x| ! Alltrim(x) $ 'ZD2_NOME' })
    Local oStruNeto  := FWFormStruct(1, cTabNeto)
    Local oModel
    Local aRelFilho  := {}
    Local aRelNeto   := {}
    Local bPre       := Nil
    Local bPos       := Nil
    Local bCommit    := Nil
    Local bCancel    := Nil


    oModel           := MPFormModel():New("zMVC08M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("ZD1MASTER", /*cOwner*/, oStruPai)
    oModel:AddGrid("ZD2DETAIL", "ZD1MASTER", oStruFilho)
    oModel:AddGrid("ZD3DETAIL", "ZD2DETAIL", oStruNeto)
    oModel:SetPrimaryKey({})
    
    oStruFilho:SetProperty("ZD2_ARTIST", MODEL_FIELD_OBRIGAT, .F.)
    aadd(aRelFilho, {"ZD2_FILIAL", "FWxFilial( 'ZD2' )"})
    aadd(aRelFilho, {"ZD2_ARTIST", "ZD1_CODIGO"})
    oModel:SetRelation("ZD2DETAIL", aRelFilho, ZD2->(IndexKey(1)))

    aadd(aRelNeto , {"ZD3_FILIAL", "FWxFilial( 'ZD3' )"})
    aadd(aRelNeto , {"ZD3_CD"    , "ZD2_CD"})
    oModel:SetRelation("ZD3DETAIL" , aRelNeto, ZD3->(IndexKey(1)))

    oModel:GetModel("ZD2DETAIL"):SetUniqueLine({ 'ZD2_CD' })
    oModel:GetModel("ZD3DETAIL"):SetUniqueLine({ 'ZD3_MUSICA' })

    oModel:AddCalc( 'TOTAIS' , 'ZD1MASTER' , 'ZD2DETAIL' , 'ZD2_CD' ,       'XX_TOTCDS' , 'COUNT' , , , "Total de CDs:")
    oModel:AddCalc( 'TOTAIS' , 'ZD2DETAIL' , 'ZD3DETAIL' , 'ZD3_MUSICA' ,   'XX_TOTMUS' , 'COUNT' , , , "Total de Musicas:" )
    
Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 09/12/2022
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("zMVC08")
    Local oStruPai := FWFormStruct(2, cTabPai)
    Local oStruFilho := FWFormStruct(2, cTabFilho, { |x| ! Alltrim(x) $ 'ZD2_NOME'})
    Local oStruNeto := FWFormStruct(2, cTabNeto)
    Local oStruTot := FwCalcStruct(oModel:GetModel('TOTAIS'))
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_ZD1", oStruPai, "ZD1MASTER")
    oView:AddGrid("VIEW_ZD2", oStruFilho, "ZD2DETAIL")
    oView:AddGrid("VIEW_ZD3", oStruNeto, "ZD3DETAIL")
    oView:AddField("VIEW_TOT", oStruTot, "TOTAIS")
    //Partes da tela
    oView:CreateHorizontalBox("CABEC_PAI", 25)
    oView:CreateHorizontalBox("ESPACO_MEIO", 60)
        oView:CreateVerticalBox("MEIO_ESQUERDA", 50, "ESPACO_MEIO")
        oView:CreateVerticalBox("MEIO_DIREITA", 50, "ESPACO_MEIO")
    oView:CreateHorizontalBox("ENCH_TOT", 15)
    oView:SetOwnerView("VIEW_ZD1", "CABEC_PAI")
    oView:SetOwnerView("VIEW_ZD2", "MEIO_ESQUERDA")
    oView:SetOwnerView("VIEW_ZD3", "MEIO_DIREITA")
    oView:SetOwnerView("VIEW_TOT", "ENCH_TOT")

    //Titulos
    oView:EnableTitleView("VIEW_ZD1", "Pai - ZD1 (Artistas)")
    oView:EnableTitleView("VIEW_ZD2", "Filho - ZD2 (CDs)")
    oView:EnableTitleView("VIEW_ZD3", "Neto - ZD3 (Musicas dos CDs)")

    //Removendo campos
    oStruFilho:RemoveField("ZD2_ARTIST")
    oStruFilho:RemoveField("ZD2_NOME")
    oStruNeto:RemoveField("ZD3_CD")

    oView:AddIncrementField("VIEW_ZD3", "ZD3_ITEM")



Return oView
