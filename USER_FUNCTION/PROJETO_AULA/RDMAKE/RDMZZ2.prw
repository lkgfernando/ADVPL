#Include "Totvs.ch"
#Include "FwMVCDef.ch"

Static cTitulo := "Tipos de Despesas"
Static cAlias := "ZZ2"


/*/{Protheus.doc} RDMZZ2
(long_description)
@type user function
@author Fernando Rodrigues
@since 16/05/2024
@version 12/Sup
/*/
User Function RDMZZ2()
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
  @since 16/05/2024
  @version 12/Sup
  @param , , 
  @return aRotina, , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function MenuDef()
  Local aRotina := {}

  ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.RDMZZ2" OPERATION 1 ACCESS 0
  ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.RDMZZ2" OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.RDMZZ2" OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.RDMZZ2" OPERATION 5 ACCESS 0
  ADD OPTION aRotina TITLE "* Func. Teste" ACTION "u_zFuncTst()" OPERATION 6  ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 16/05/2024
  @version 12/
  @param , , 
  @return oModel, , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function ModelDef()
  Local oStruct := FwFormStruct(1,cAlias)
  Local oModel
  Local bPre := Nil
  Local bPos := Nil
  Local bCommit := Nil
  Local bCancel := Nil

  oModel := MpFormModel():New("RDMZZ2M", bPre, bPos, bCommit, bCancel)
  oModel:AddFields("RDMZZ2MASTER", /*cOwner*/, oStruct)
  oModel:SetDescription("Modelo de dados " + cTitulo)
  oModel:GetModel("RDMZZ2MASTER"):SetDescription("Dados de - " + cTitulo)
  oModel:SetPrimaryKey({})

Return oModel

/*/{Protheus.doc} ViewDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 16/05/2024
  @version 12/
  @param , , 
  @return oView, , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function ViewDef()
  Local oModel := FwLoadModel("RDMZZ2")
  Local oStruct := FwFormStruct(2, cAlias)
  Local oView

  oView := FwFormView():New()
  oView:SetModel(oModel)
  oView:AddField("VIEW_ZZ2", oStruct, "RDMZZ2MASTER")
  oView:CreateHorizontalBox("TELA", 100)
  oView:SetOwnerView("VIEW_ZZ2", "TELA")

Return oView

/*/{Protheus.doc} zFuncTst
(long_description)
@type user function
@author Fernando Rodrigues
@since 16/05/2024
@version 12/
/*/
User Function zFuncTst()
  Local cTitulo := "Teste de menu MVC"

  FwAlertInfo("Teste de menu OK", cTitulo)

Return 
