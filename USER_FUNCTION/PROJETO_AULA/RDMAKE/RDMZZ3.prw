#Include "Totvs.ch"
#Include "FwMVCDef.ch"

Static cTitulo := "Cadastro de Contas"
Static cAlias := "ZZ3"

/*/{Protheus.doc} RDMZZ3
(long_description)
@type user function
@author Fernando Rodrigues
@since 20/05/2024
@version 12/Sup
@param , , 
@return , , 
@example
(examples)
@see (links_or_references)
/*/
User Function RDMZZ3()
  Local aArea := FwGetArea()
  Local oBrowse
  Private aRotina := {}

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
  @since 20/05/2024
  @version 12/Sup
  @param , , 
  @return aRotina, , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function MenuDef()
  Local aRotina := {}

  ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.RDMZZ3" OPERATION 1 ACCESS 0
  ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.RDMZZ3" OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.RDMZZ3" OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.RDMZZ3" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 20/05/2024
  @version 12/Sup
/*/
Static Function ModelDef()
  Local oStruct := FwFormStruct(1, cAlias)
  Local oModel
  Local bPre := Nil
  Local bPos := Nil
  Local bCommit := Nil
  Local bCancel := Nil

  oModel := MPFormModel():New("RDMZZ3M", bPre, bPos, bCommit, bCancel)
  oModel:AddFields("ZZ3MASTER", /*cOwner*/, oStruct)
  oModel:SetDescription("Modelo de dados - " + cTitulo)
  oModel:GetModel("ZZ3MASTER"):SetDescription("Dados de - " + cTitulo)
  oModel:SetPrimaryKey({})


Return oModel

/*/{Protheus.doc} ViewDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 20/05/2024
  @version 12/
  @param , , 
  @return oView, , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function ViewDef()
  Local oModel := FwLoadModel("RDMZZ3")
  Local oStruct := FwFormStruct(2,cAlias)
  Local oView

  oView := FwFormView():New()
  oView:SetModel(oModel)
  oView:AddField("VIEW_ZZ3", oStruct, "ZZ3MASTER")
  oView:CreateHorizontalBox("TELA",100)
  oView:SetOwnerView("VIEW_ZZ3", "TELA")

Return oView
