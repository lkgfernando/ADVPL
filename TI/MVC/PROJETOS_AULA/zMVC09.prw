#Include "Totvs.ch"
#Include "FWMVCDef.ch"


//Variaveis estaticas
Static cTitulo := "Artistas"
Static cAliasMVC := "ZD1"


/*/{Protheus.doc} User Function zMVC09
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 24/11/2022
  /*/

User Function zMVC09()
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

  ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC09" OPERATION 1 ACCESS 0
  ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC09" OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.zMVC09" OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC09" OPERATION 5 ACCESS 0

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

  oModel := MPFormModel():New("zMVC09M", bPre, bPos, bCommit, bCancel)
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
  Local cCampoPrin := "ZD1_CODIGO|ZD1_NOME"
  Local cCampoObse := "ZD1_DTFORM|ZD1_OBSERV"
  Local oModel := FWLoadModel("zMVC09")
  Local oStructPrin := FWFormStruct(2, cAliasMVC, {|cCampo| AllTrim(cCampo) $ cCampoPrin})
  Local oStructObse := FWFormStruct(2, cAliasMVC, {|cCampo| Alltrim(cCampo) $ cCampoObse})
  Local oView

oStructPrin:SetNoFolder()
oStructObse:SetNoFolder()

oView := FWFormView():New()
oView:SetModel(oModel)
oView:AddField("VIEW_PRIN", oStructPrin, "ZD1MASTER")
oView:AddField("VIEW_OBSE", oStructObse, "ZD1MASTER")

oView:CreateFolder('ABAS')
oView:AddSheet('ABAS', 'ABA_PRIN', 'Aba principal do Cadastro')
oView:AddSheet('ABAS', 'ABA_OBSE', 'Aba com campos Observação')

oView:CreateHorizontalBox('BOX_PRI', 100, /*owner*/, /*lUsePixel*/, 'ABAS','ABA_PRIN')
oView:CreateHorizontalBox('BOX_OBSE', 100, /*owner*/, /*lUsePixel*/, 'ABAS', 'ABA_OBSE')


oView:SetOwnerView("VIEW_PRIN", "BOX_PRI")
oView:SetOwnerView("VIEW_OBSE", "BOX_OBSE")

Return oView
