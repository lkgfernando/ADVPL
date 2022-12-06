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
    Local aArea := GetArea()
    Local oBrowse
    Private aRot := {}

    aRot := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias("ZD4")
    oBrowse:SetDescription(cTitulo)
    oBrowse:Activate()

    RestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/12/2022
/*/
Static Function MenuDef()
    Local aRot := {}

    ADD OPTION aRot TITLE 'Vizualizar' ACTION 'VIEWDEF.zMVC04' OPERATION MODEL_OPERATION_VIEW ACCESS 0 //OPERATION 1
    ADD OPTION aRot TITLE 'Incluir' ACTION 'VIEWDEF.zMVC04' OPERATION MODEL_OPERATION_INSERT ACCESS 0  //OPERATION 3
    ADD OPTION aRot TITLE 'Alterar' ACTION 'VIEWDEF.zMVC04' OPERATION MODEL_OPERATION_UPDATE ACCESS 0  //OPERATION 4
    ADD OPTION aRot TITLE 'Excluir' ACTION 'VIEWDEF.zMVC04' OPERATION MODEL_OPERATION_DELETE ACCESS 0  //OPERATION 5

Return aRot


/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/12/2022
/*/
Static Function ModelDef()
    Local oModel := Nil
    Local oStruCab := FWFormStruct(1, 'ZD4', {|cCampo| Alltrim(cCampo) $ cCamposChv})
    Local oStruGrid := fModStruct()

    oModel := MPFormModel():New('zMVC04M', /*bPreValidacao*/, /*bProsValidacao*/, /*bCommit*/, /*bCancel*/)

    oModel:AddFields('MASTERZD4', Nil, oStruCab)
    oModel:AddGrid('GRIDZD4', 'MASTERZD4', oStruGrid)

    oModel:SetRelation('GRIDZD4', {;
                        {'ZD4_FILIAL', 'xFilial("ZD4")'},;
                        {'ZD4_ANO', 'ZD4_ANO'};
                        }, ZD4->(IndexKey(1)))
    oModel:GetModel("GRIDZD4"):SetMaxLine(9999)
    oModel:SetDescription("Cadastro de Premiações")
    oModel:SetPrimaryKey({"ZD4_FILIAL", "ZD4_ANO"})


Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/12/2022
/*/
Static Function ViewDef()
    Local oView := Nil
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


/*/{Protheus.doc} fViewStruct
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/12/2022
/*/

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

Static Function fViewStruct()
    Local oStruct
    oStruct := FWFormStruct(2, 'ZD4', {|cCampo| ! (Alltrim(cCampo) $ cCamposChv)})
Return oStruct
