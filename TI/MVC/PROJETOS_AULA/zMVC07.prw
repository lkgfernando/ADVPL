#Include "Totvs.ch"
#Include "FWMVCDef.ch"


//Variaveis estaticas
Static cTitulo := "Artistas"
Static cAliasMVC := "ZD1"


/*/{Protheus.doc} User Function zMVC01
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 24/11/2022
  /*/

User Function zMVC07()
  Local aArea := GetArea()
  Local oBrowse
  Private aRotina := {}

  aRotina := MenuDef()

  oBrowse := FWMBrowse():New()
  oBrowse:SetAlias(cAliasMVC)
  oBrowse:SetDescription(cTitulo)
  oBrowse:DisableDetails()

  oBrowse:Activate()

  RestArea(aArea)

Return Nil


/*/{Protheus.doc} MenuDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 24/11/2022
/*/
Static Function MenuDef()
  Local aRotina := {}

  ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC07" OPERATION 1 ACCESS 0
  ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC07" OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC07" OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC07" OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 24/11/2022
/*/
Static Function ModelDef()
  Local oStruct := FWFormStruct(1, cAliasMVC)
  Local oModel
  Local bPre := Nil
  Local bPos := Nil
  Local bCommit := Nil
  Local bCancel := Nil

  oModel := MPFormModel():New("zMVC07M", bPre, bPos, bCommit, bCancel)
  oModel:AddFields("ZD1MASTER", /*cOwner*/, oStruct)
  oModel:SetDescription("Modelo de dados - " + cTitulo)
  oModel:GetModel("ZD1MASTER"):SetDescription("Dados de - " + cTitulo)
  oModel:SetPrimaryKey({})

Return oModel

/*/{Protheus.doc} ViewDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 24/11/2022
/*/
Static Function ViewDef()
  Local oModel := FWLoadModel("zMVC07")
  Local oStruct := FWFormStruct(2, cAliasMVC)
  Local oView

oView := FWFormView():New()
oView:SetModel(oModel)
oView:AddField("VIEW_ZD1", oStruct, "ZD1MASTER")
oView:CreateHorizontalBox("TELA", 100)
oView:SetOwnerView("VIEW_ZD1", "TELA")

// Adicionado botões no outra ações da ViewDef
// Parâmetros do médoto addUserButton (<<cTitle>>, <cResource>, <bBloco>, [cToolTip], [nShortCut], [aOptions], [lShowBar])
oView:addUserbutton("Mensagem", "MAGIC_BMP", {|| Alert("Apenas uma mensagem de teste")}, , , , .T.)
oView:addUserButton("Imprimir", "MAGIC_BMP", {|| Alert("Em construção")               }, , , , .F.)

Return oView
