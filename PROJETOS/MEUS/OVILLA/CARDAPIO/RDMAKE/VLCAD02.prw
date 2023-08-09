#Include "Totvs.ch"
#Include "FWMVCDef.ch"


Static cTitulo   := "Grupo Produtos X Produtos X Ingredientes"
Static cTabPai   := "SZ1"
Static cTabFilho := "SZ2"
Static cTabNeto  := "SZ3"


/*/{Protheus.doc} User Function VLCAD02
    (Criação de RDMAKE para Grupo de produtos x Produtos x Ingredientes)
    @type  Function
    @author Fernando Rodrigues
    @since 07/08/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function VLCAD02()
    Local aArea     := FWGetArea()
    Local oBrowse
    Private aRotina := {}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cTabPai)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetails()

    oBrowse:Activate()

    FWRestArea(aArea)
Return Nil 

/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 07/08/2023
    @version 1.0
    @param , , 
    @return aRotina, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.VLCAD02" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.VLCAD02" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.VLCAD02" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.VLCAD02" OPERATION 5 ACCESS 0

Return aRotina


/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 07/08/2023
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
    Local oStruNeto  := FWFormStruct(1, cTabNeto)
    Local aRelFilho  := {}
    Local aRelNeto   := {}
    Local oModel
    Local bPre       := Nil
    Local bPos       := Nil
    Local bCommit    := Nil
    Local bCancel    := Nil

    oModel := MPFormModel():New("VLCAD02M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("SZ1MASTER", /*cOwner*/, oStruPai)
    oModel:AddGrid("SZ2DETAIL","SZ1MASTER", oStruFilho)
    oModel:AddGrid("SZ3DETAIL","SZ2DETAIL", oStruNeto)
    oModel:SetPrimaryKey({})

    oStruFilho:SetProperty("Z2_GRPPRD", MODEL_FIELD_OBRIGAT, .F.)
    aAdd(aRelFilho, {"Z2_FILIAL", "FWxFilial('SZ2')"})
    aAdd(aRelFilho, {"Z2_GRPPRD", "Z1_CODGRP"})
    oModel:SetRelation("SZ2DETAIL", aRelFilho, SZ2->(IndexKey(1)))

    aAdd(aRelNeto, {"Z3_FILIAL", "FWxFilial('SZ3')"})
    aAdd(aRelNeto, {"Z3_Z2COD", "Z2_CODPROD"})
    oModel:SetRelation("SZ3DETAIL", aRelNeto, SZ3->(IndexKey(1)))

    oModel:GetModel("SZ2DETAIL"):SetUniqueLine({'Z2_CODPROD'})
    oModel:GetModel("SZ3DETAIL"):SetUniqueLine({'Z3_CODPRD'})


Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 07/08/2023
    @version 1.0
    @param , , 
    @return oView, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ViewDef()
    Local oModel     := FWLoadModel("VLCAD02")
    Local oStruPai   := FWFormStruct(2, cTabPai)
    Local oStruFilho := FWFormStruct(2, cTabFilho)
    Local oStruNeto  := FWFormStruct(2, cTabNeto)

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_SZ1", oStruPai, "SZ1MASTER")
    oView:AddGrid("VIEW_SZ2", oStruFilho, "SZ2DETAIL")
    oView:AddGrid("VIEW_SZ3", oStruNeto, "SZ3DETAIL")

    oView:CreateHorizontalBox("CABEC_PAI", 10)
    oView:CreateHorizontalBox("GRID_FILHO", 40)
    oView:CreateHorizontalBox("GRID_NETO", 50)
    oView:SetOwnerView("VIEW_SZ1", "CABEC_PAI")
    oView:SetOwnerView("VIEW_SZ2", "GRID_FILHO")
    oView:SetOwnerView("VIEW_SZ3", "GRID_NETO")

    oView:EnableTitleView("VIEW_SZ1", "Pai - SZ1 Grupo Produtos")
    oView:EnableTitleView("VIEW_SZ2", "Filho - SZ2 Produtos")
    oView:EnableTitleView("VIEW_SZ3", "Neto - SZ3 - Ingredientes")

    oStruFilho:RemoveField("Z2_GRPPRD")
    oStruNeto:RemoveField("Z3_Z2COD")

    oView:AddIncrementField("VIEW_SZ3", "Z3_ITEM")

Return oView
