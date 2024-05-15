#Include "Totvs.ch"
#Include "FwMVCDef.ch"

//Variaveis Estaticas 

Static cTitulo := "Grupo de Despesas"
Static cAlias  := "ZZ1"

/*/{Protheus.doc} RDMZZ1
(long_description)
@type user function
@author Ferrnando Rodrigues
@since 13/05/2024
@version 12/Sup
@example
(examples)
@see (links_or_references)
/*/
User Function RDMZZ1()
  Local aArea := FwGetArea()
  Local oBrowse 
  Private aRotina := {}

  //Define o menu
  aRotina := MenuDef()

  oBrowse := FwMBrowse():New()
  oBrowse:SetAlias(cAlias)
  oBrowse:SetDescription(cTitulo)
  oBrowse:DisableDetails()

  oBrowse:Activate()

  FwRestArea(aArea)

Return 

/*/{Protheus.doc} MenuDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 13/05/2024
  @version 12/sup
  @return aRotina, , 
/*/
Static Function MenuDef()
  Local aRotina := {}

  ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.RDMZZ1" OPERATION 1 ACCESS 0
  ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.RDMZZ1" OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.RDMZZ1" OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.RDMZZ1" OPERATION 5 ACCESS 0

Return aRotina


/*/{Protheus.doc} ModelDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 13/05/2024
  @version 12/Sup
  @return oModel, , 
/*/
Static Function ModelDef()
  Local oStruct := FwFormStruct(1,cAlias)  
  Local oModel 
  Local bPre := Nil
  Local bPos := Nil
  Local bCommit := Nil
  Local bCancel := Nil

  oModel := MpFormModel():New("RDMZZ1M", bPre, bPos, bCommit, bCancel)
  oModel:AddFields("RDMZZ1MASTER", /*cOwner*/, oStruct)
  oModel:SetDescription("Modelo de dados " + cTitulo)
  oModel:GetModel("RDMZZ1MASTER"):SetDescription("Dados de - " + cTitulo)
  oModel:SetPrimaryKey({})

Return oModel

/*/{Protheus.doc} ViewDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 13/05/2024
  @version 12/Sup
  @return oView, , 
/*/
Static Function ViewDef()
  Local oModel := FwLoadModel("RDMZZ1")
  Local oStruct := FwFormStruct(2, cAlias)
  Local oView

  oView := FwFormView():New()
  oView:SetModel(oModel)
  oView:AddField("VIEW_ZZ1", oStruct, "RDMZZ1MASTER")
  oView:CreateHorizontalBox("TELA", 100)
  oView:SetOwnerView("VIEW_ZZ1", "TELA")

Return oView
