#Include "Totvs.ch"
#Include "FWMVCDef.ch"


// Cria browse da tabela de moedas

Static cTitulo := "Cadastro de Moedas/Notas"
Static cZV1 := "ZV1"


/*/{Protheus.doc} User Function VLZV101
  (Cria browse da tabela para cadastro de moedas)
  @type  Function
  @author Fernando Rodrigues
  @since 27/11/2022
  @version 1.0
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function VLZV101()
  Local aArea := GetArea()
  Local oBrowse
  Private aRotina := {}

  aRotina := MenuDef()

  oBrowse := FWMBrowse():New()
  oBrowse:SetAlias(cZV1)
  oBrowse:SetDescription(cTitulo)
  oBrowse:DisableDetails()

  oBrowse:Activate()

  RestArea(aArea)
Return Nil

/*/{Protheus.doc} MenuDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 28/11/2022
/*/
Static Function MenuDef()
  Local aRotina := {}

  ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.VLZV101" OPERATION 1 ACCESS 0
  ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.VLZV101" OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.VLZV101" OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.VLZV101" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 28/11/2022
/*/
Static Function ModelDef()
  Local oStruct := FWFormStruct(1, cZV1)
  Local oModel
  Local bPre    := Nil
  Local bPos    := Nil
  Local bCommit := Nil
  Local bCancel := Nil
  
  oModel := MPFormModel():New("VLZV101M", bPre, bPos, bCommit, bCancel)
  oModel:AddFields("ZV1MASTER", /**/, oStruct)
  oModel:SetDescription("Modelo de dados - " + cTitulo)
  oModel:GetModel("ZV1MASTER"):SetDescription("Dados de - " + cTitulo)
  oModel:SetPrimaryKey({})

Return oModel

/*/{Protheus.doc} ViewDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 28/11/2022
/*/
Static Function ViewDef()
  Local oModel := FWLoadModel("VLZV101")
  Local oStruct := FWFormStruct(2, cZV1)
  Local oView

  oView := FWFormView():New()
  oView:SetModel(oMOdel)
  oView:AddField("VIEW_ZV1", oStruct, "ZV1MASTER")
  oView:CreateHorizontalBox("TELA", 100)
  oView:SetOwnerView("VIEW_ZV1", "TELA")

Return oView
