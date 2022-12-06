#Include "Totvs.ch"
#Include "FWMVCdef.ch"



Static cTitulo := "Premiações"
Static cCamposChv := "ZD4_ANO"



/*/{Protheus.doc} User Function zMVC04
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 06/12/2022
    /*/
User Function zMVC04()
    Local aArea := FWGetArea()
    Local oBrowse
    Private aRotina := {}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias("ZD4")
    oBrowse:SetDescription(cTitulo)
    oBrowse:Activate()

    FWRestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/12/2022
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Vizualizar' ACTION 'VIEWDEF.zMVC04' OPERATION 1 ACCESS 0 //OPERATION 1 MODEL_OPERATION_VIEW
    ADD OPTION aRotina TITLE 'Incluir' ACTION 'VIEWDEF.zMVC04' OPERATION 3 ACCESS 0  //OPERATION 3 MODEL_OPERATION_INSERT
    ADD OPTION aRotina TITLE 'Alterar' ACTION 'VIEWDEF.zMVC04' OPERATION 4 ACCESS 0  //OPERATION 4 MODEL_OPERATION_UPDATE
    ADD OPTION aRotina TITLE 'Excluir' ACTION 'VIEWDEF.zMVC04' OPERATION 5 ACCESS 0  //OPERATION 5 MODEL_OPERATION_DELETE

Return aRotina


/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/12/2022
/*/
Static Function ModelDef()
    Local oModel 
    Local oStruCab := FWFormStruct(1, "ZD4", {|cCampo| Alltrim(cCampo) $ cCamposChv})
    Local oStruGrid := fModStruct()
    Local aRelation := {}

    oModel := MPFormModel():New('zMVC04M', /*bPreValidacao*/, /*bProsValidacao*/, /*bCommit*/, /*bCancel*/)

    oModel:AddFields('MASTERZD4', Nil , oStruCab)
    oModel:AddGrid('GRIDZD4', 'MASTERZD4', oStruGrid)
    oModel:GetModel("MASTERZD4"):SetDescription("Dados - " + cTitulo)
    oModel:GetModel("GRIDZD4"):SetDescription("Grid de  - " + cTitulo)
    oModel:SetPrimaryKey({"ZD4_FILIAL", "ZD4_ANO"})

    aAdd(aRelation, {"ZD4_FILIAL", "FWxFilial('ZD4')"})
    aAdd(aRelation, {"ZD4_ANO", "ZD4_ANO"})

    oModel:SetRelation('GRIDZD4', aRelation, ZD4->(IndexKey(1)))

    //oModel:GetModel("GRIDZD4"):SetMaxLine(9999)


Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/12/2022
/*/
Static Function ViewDef()
    Local oView 
    Local oModel := FWLoadModel('zMVC04')
    Local oStruCab := FWFormStruct(2, "ZD4", {|cCampo| Alltrim(cCampo) $ cCamposChv})
    Local oStruGrd := fVeiwStruct()

    oStruCab:SetNoFolder()

    oView := FWFormView():New()
    oView:SetModel(oModel)

    oView:AddField('VIEW_ZD4', oStruCab, 'MASTERZD4')
    oView:AddGrid('VGRD_ZD4', oStruGrd, 'GRIDZD4')

    oView:CreateHorizontalBox("MAIN", 25)
    oView:CreateHorizontalBox("GRID", 75)

    oView:SetOwnerView('VIEW_ZD4', 'MAIN')
    oView:SetOwnerView('VGRD_ZD4', 'GRID')
    oView:EnableControlBar(.T.)

    oView:AddIncrementField('VGRD_ZD4', 'ZD4_ITEM')

Return oView


/*/{Protheus.doc} fModStruct
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/12/2022
/*/
Static Function fModStruct()
    Local oStruct
    oStruct := FWFormStruct(1, 'ZD4')
Return oStruct

/*/{Protheus.doc} fViewStruct
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/12/2022
/*/

Static Function fViewStruct()
    Local oStruct
    oStruct := FWFormStruct(2, "ZD4", {|cCampo| ! Alltrim(cCampo) $ cCamposChv})
Return oStruct
