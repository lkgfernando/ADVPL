#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variaveis Estaticas
Static cTitulo := "Planejamento Samanal"
Static cAliasMVC := "ZP1"


/*/{Protheus.doc} User Function ZP1MVC1
    Cadastro de Planejamento
    @type  Function
    @author Fernando José Rodrigues
    @since 07/10/2022
    /*/

User Function ZP1MVC1()
    Local aArea := GetArea()
    Local oBrowse
    Private aRotina := {}

    //Definicao do menu
    aRotina := MenuDef()

    //Intanciando o Browser
    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cAliasMVC)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetails()

    //Ativa a Browse
    oBrowse:Activate()

    RestArea(aArea)

Return Nil

/*/{Protheus.doc} MenuDef
    Menu de opcoes na funcao ZP1MVC1
    @type  Static Function
    @author Fernando José Rodrigues
    @since 07/10/2022
/*/
Static Function MenuDef()
    Local aRotina := {}

    //Adiciona opçoes do menu
    ADD OPTION aRotina TITLE "Visualizar"   ACTION "VIEWDEF.ZP1MVC1" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir"      ACTION "VIEWDEF.ZP1MVC1" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar"      ACTION "VIEWDEF.ZP1MVC1" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir"      ACTION "VIEWDEF.ZP1MVC1" OPERATION 5 ACCESS 0    

Return aRotina

User Function z01Model()
    
Return ModelDef()

/*/{Protheus.doc} ModelDef
    Modelo de dados na fucan ZP1MVC1
    @type  Static Function
    @author user
    @since 07/10/2022
/*/
Static Function ModelDef()
    Local oStruct := FWFormStruct(1, cAliasMVC)
    Local oModel
    Local bPre    := Nil
    Local bPos    := Nil
    Local bCommit := Nil
    Local bCancel := Nil

    //Cria o modelo de dados para cadastro
    oModel := MPFormModel():New("ZP1MVC1M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("ZP1MASTER", /*cOwner*/, oStruct)
    oModel:SetDescription("Modelo de dados - " + cTitulo)
    oModel:GetModel("ZP1MASTER"):SetDescription("Dados de - " + cTitulo)
    oModel:SetPrimaryKey({})

Return oModel

/*/{Protheus.doc} ViewDef
    Visualizacao de dados na funcao ZP1MVC1
    @type  Static Function
    @author Fernando Jose Rodrigues
    @since 07/10/2022
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("ZP1MVC1")
    Local oStruct := FWFormStruct(2, cAliasMVC)
    Local oView

    //Cria a visualizacao do cadastro
    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_ZP1", oStruct, "ZP1MASTER")
    oView:CreateHorizontalBox("TELA", 100)
    oView:SetOwnerView("VIEW_ZP1", "TELA")
    
Return oView
