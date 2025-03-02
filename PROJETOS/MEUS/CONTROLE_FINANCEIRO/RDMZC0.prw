//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Saldo das Contas"
Static cAliasMVC := "ZC0"

/*/{Protheus.doc} User Function RDMZC0
SALDO DE CONTAS
@author Fernando Jose Rodrigues
@since 06/06/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function RDMZC0()
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
Menu de opcoes na funcao RDMZC0
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
	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.RDMZC0" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.RDMZC0" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.RDMZC0" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.RDMZC0" OPERATION 5 ACCESS 0


Return aRotina

/*/{Protheus.doc} ModelDef
Modelo de dados na funcao RDMZC0
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
	oModel := MPFormModel():New("RDMZC0M", bPre, bPos, /*bCommit*/, bCancel)
	oModel:AddFields("ZC0MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("ZC0MASTER"):SetDescription( "Dados de - " + cTitulo)
	oModel:SetPrimaryKey({})
 

Return oModel

/*/{Protheus.doc} ViewDef
Visualizacao de dados na funcao RDMZC0
@author Fernando Jose Rodrigues
@since 06/06/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function ViewDef()
	Local oModel := FWLoadModel("RDMZC0")
	Local oStruct := FWFormStruct(2, cAliasMVC)
	Local oView

	//Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZC0", oStruct, "ZC0MASTER")
	oView:CreateHorizontalBox("TELA" , 100 )
	oView:SetOwnerView("VIEW_ZC0", "TELA")

Return oView
