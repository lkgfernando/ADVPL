//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Controle Financeiro Pessoal"
Static cAliasMVC := "ZC1"

/*/{Protheus.doc} User Function RDMZC1
Controle Finaceiro Pessoal
@author Fernando Jose Rodrigues
@since 06/06/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function RDMZC1()
	Local aArea   := FWGetArea()
	Local oBrowse
	Private aRotina := {}

	//Definicao do menu
	aRotina := MenuDef()

	//Instanciando o browse
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias(cAliasMVC)
	oBrowse:SetDescription(cTitulo)
	oBrowse:DisableDetails()

	//Ativa a Browse
	oBrowse:Activate()

	FWRestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
Menu de opcoes na funcao RDMZC1
@author Fernando Jose Rodrigues
@since 06/06/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function MenuDef()
	Local aRotina := {}

	//Adicionando opcoes do menu
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.RDMZC1" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.RDMZC1" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.RDMZC1" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.RDMZC1" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao RDMZC1
@author Fernando Jose Rodrigues
@since 06/06/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ModelDef()
	Local oStruct := FWFormStruct(1, cAliasMVC)
	Local oModel
	Local bPre := Nil
	Local bPos := Nil
	Local bCancel := Nil


	//Cria o modelo de dados para cadastro
	oModel := MPFormModel():New("RDMZC1M", bPre, bPos, /*bCommit*/, bCancel)
	oModel:AddFields("ZC1MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("ZC1MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:SetPrimaryKey({})
Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao RDMZC1
@author Fernando Jose Rodrigues
@since 06/06/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("RDMZC1")
	Local oStruct := FWFormStruct(2, cAliasMVC)
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZC1", oStruct, "ZC1MASTER")
	oView:CreateHorizontalBox("TELA" , 100 )
	oView:SetOwnerView("VIEW_ZC1", "TELA")

Return oView
