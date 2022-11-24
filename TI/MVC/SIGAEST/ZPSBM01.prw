#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variaveis Estaticas
Static cTitle := "Grupo de Produtos"
Static cAliasMVC := "SBM"


/*/{Protheus.doc} User Function ZPSBM01
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 23/11/2022
    /*/
User Function ZPSBM01()
    Local aArea := GetArea()
    Local oBrowse
    Private aRotina := {}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cAliasMVC)
    oBrowse:SetDescription(cTitle)
    oBrowse:DisableDetails()

    oBrowse:Activate()

    RestArea(aArea)
Return Nil


/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 23/11/2022
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar " ACTION "VIEWDEF.ZPSBM01" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir"     ACTION "VIEWDEF.ZPSBM01" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar"     ACTION "VIEWDEF.ZPSBM01" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir"     ACTION "VIEWDEF.ZPSBM01" OPERATION 5 ACCESS 0
    
    
Return aRotina

/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 23/11/2022
/*/
Static Function ModelDef()
    Local oStruct := FWFormStruct(1, cAliasMVC)
    Local oModel
    Local bPre    := Nil
    Local bPos    := Nil
    Local bCommit := Nil
    Local bCancel := Nil

    oModel := MPFormModel():New("ZPSBM01M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("SBMMASTER", /*cOwner*/, oStruct)
    oModel:SetDescription("Modelo de dados = " + cTitle) 
    oModel:SetPrimaryKey({})

Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 23/11/2022
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("ZPSBM01")
    Local oStruct := FWFormStruct(2, cAliasMVC)
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_ZD1", oStruct, "SBMMASTER")
    oView:CreateHorizontalBox("SCREEN", 100)
    oView:SetOwnerView("VIEW_ZD1", "SCREEN")

Return oView

