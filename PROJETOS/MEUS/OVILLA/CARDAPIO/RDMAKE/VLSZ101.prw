#Include "Totvs.ch"
#Include "FWMVCDef.ch"


Static cTitulo  := "Grupo de Produtos Cardapio"
Static cAlias   := "SZ1"


/*/{Protheus.doc} User Function VLSZ101
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 31/07/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function VLSZ101()
    Local aArea := FWGetArea()
    Local oBrowse
    Private aRotina := {}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cAlias)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetails()

    oBrowse:Activate()

    FWRestArea(aArea)

Return 


/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 31/07/2023
    @version 
    @param , , 
    @return aRotina , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.VLSZ101" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.VLSZ101" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.VLSZ101" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.VLSZ101" OPERATION 5 ACCESS 0

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
    Local oStruct := FWFormStruct(1, cAlias)
    Local oModel 
    Local bPre := Nil
    Local bPos := Nil
    Local bCommit := Nil
    Local bCancel := Nil


    oModel := MPFormModel():New("VLSZ101M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("SZ1MASTER", /*cOwner*/, oStruct)
    oModel:SetDescription("Modelo de dados - " + cTitulo)
    oModel:GetModel("SZ1MASTER"):SetDescription("Dados de - " + cTitulo)
    oModel:SetPrimaryKey({'Z1_FILIAL','Z1_CODGRP'})

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
    Local oModel := FWLoadModel("VLSZ101")
    Local oStruct := FWFormStruct(2, cAlias)
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_SZ1", oStruct, "SZ1MASTER")
    oView:CreateHorizontalBox("TELA", 100)
    oView:SetOwnerView("VIEW_SZ1", "TELA")
    
Return oView
