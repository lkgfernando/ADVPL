#Include "Totvs.ch"
#Include "FWMVCDef.ch"

Static cTitulo := "Movimento de Despesas"
Static cAliasPai := "ZZ4"
Static cAliasFil := "ZZ5"

/*/{Protheus.doc} MOVDEP1
(long_description)
@type user function
@author Fernando Rodrigues
@since 22/05/2024
@version 12/
@param , , 
@return , , 
@example
(examples)
@see (links_or_references)
/*/
User Function MOVDEP1()
  Local aArea     := FwGetArea()
  Local oBrowse
  Private aRotina := {}

  aRotina         := MenuDef()

  oBrowse := FwMBrowse():New()

  oBrowse:AddLegend("ZZ4->ZZ4_STATUS == 'A'", "GREEN", "Aberto")
  oBrowse:AddLegend("ZZ4->ZZ4_STATUS == 'E'", "RED", "Efetivado")
  oBrowse:AddLegend("ZZ4->ZZ4_STATUS == 'P'", "YELLOW", "Pago")
  oBrowse:AddLegend("ZZ4->ZZ4_STATUS == 'C'", "CANCEL", "Cancelado")

  oBrowse:SetAlias(cAliasPai)
  oBrowse:SetDescription(cTitulo)
  oBrowse:DisableDetails()

  oBrowse:Activate()

  FwRestArea(aArea)

Return Nil

/*/{Protheus.doc} MenuDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 22/05/2024
  @version 12/Sup
  @return aRotina, , 
/*/
Static Function MenuDef()
  Local aRotina := {}
  
  ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.MOVDEP1" OPERATION 1 ACCESS 0
  ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.MOVDEP1" OPERATION 3 ACCESS 0
  ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.MOVDEP1" OPERATION 4 ACCESS 0
  ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.MOVDEP1" OPERATION 5 ACCESS 0
  ADD OPTION aRotina TITLE "Imprimir" ACTION "VIEWDEF.MOVDEP1" OPERATION 8 ACCESS 0
  ADD OPTION aRotina TITLE "Copiar" ACTION "VIEWDEF.MOVDEP1" OPERATION 9 ACCESS 0
  ADD OPTION aRotina TITLE "#Efetivar" ACTION "u_FIN050INC()" OPERATION 4 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 22/05/2024
  @version 12/
  @param , , 
  @return oModel, , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function ModelDef()
  Local oStrPai   := FwFormStruct(1, cAliasPai)
  Local oStrFilho := FwFormStruct(1, cAliasFil)
  Local aRelation := {}
  Local oModel
  Local bPre      := Nil
  Local bPos      := Nil
  Local bCommit   := Nil
  Local bCancel   := Nil

  oModel := MPFormModel():New("MOVDEP1M", bPre, bPos, bCommit, bCancel)
  oModel:AddFields("ZZ4MASTER", /*cOwner*/, oStrPai)
  oModel:AddGrid("ZZ5DETAIL","ZZ4MASTER",oStrFilho, {|oModel| u_MOVDEP1A(oModel)})
  oModel:SetDescription("Modelo de dados - " + cTitulo)
  oModel:GetModel("ZZ4MASTER"):SetDescription("Dados de - " + cTitulo)
  oModel:GetModel("ZZ5DETAIL"):SetDescription("Grid de - " + cTitulo)
  oModel:SetPrimaryKey({'ZZ4_FILIAL','ZZ4_COD'})
  //Relacionamento
  aAdd(aRelation, {"ZZ5_FILIAL", "FWxFilial('ZZ5')"})
  aAdd(aRelation, {"ZZ5_CODZZ4", "ZZ4_COD"})
  oModel:SetRelation("ZZ5DETAIL", aRelation, ZZ5->(IndexKey(1)))

  oModel:GetModel('ZZ5DETAIL'):SetUniqueLine({'ZZ5_CODDES'})
  oModel:AddCalc("QUANT", "ZZ4MASTER", "ZZ5DETAIL", "ZZ5_TOTAL", "QUANTIDADE:", "COUNT")

Return oModel


/*/{Protheus.doc} ViewDef
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 22/05/2024
  @version 12/
  @param , , 
  @return oView, , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function ViewDef()
  Local oModel    := FwLoadModel("MOVDEP1")
  Local oStrPai   := FwFormStruct(2, cAliasPai)
  Local oStrFilho := FwFormStruct(2, cAliasFil)
  Local oView
  Local oQuant   


  oView := FwFormView():New()
  oView:SetModel(oModel)
  oQuant := FwCalcStruct(oModel:GetModel("QUANT"))
  oView:AddField("VIEW_ZZ4", oStrPai, "ZZ4MASTER")
  oView:AddGrid("VIEW_ZZ5",oStrFilho,"ZZ5DETAIL")
  oView:AddField("VIEW_QUANT", oQuant, "QUANT")

  oView:CreateHorizontalBox("CABEC", 30)
  oView:CreateHorizontalBox("GRID", 60)
  oView:CreateHorizontalBox("BOX_QUANT", 10)
  oView:SetOwnerView("VIEW_ZZ4", "CABEC")
  oView:SetOwnerView("VIEW_ZZ5", "GRID")
  oView:SetOwnerView("VIEW_QUANT", "BOX_QUANT")

  oView:EnableTitleView("VIEW_ZZ4", "Cabecalho - ZZ4 Movimentos Despesa")
  oView:EnableTitleView("VIEW_ZZ5", "Grid - ZZ5 (Detalhes dos Movimentos)")




  oStrFilho:RemoveField("ZZ5_CODZZ4")

  oView:AddIncrementField("VIEW_ZZ5", "ZZ5_ITEM")

Return oView

/*/{Protheus.doc} MOVDEP1A
(long_description)
@type user function
@author Fernando Rodrigues
@since 27/05/2024
@version 12/

/*/
User Function MOVDEP1A(oModelZZ5)
  Local aArea     := FwGetArea()
  Local oModel    := FwModelActive()
  Local oModelZZ4 := oModel:GetModel( 'ZZ4MASTER' )
  Local nTotal    := 0
  Local nI        := 0

  For nI := 1 To oModelZZ5:Length()

    oModelZZ5:GoLine(nI)

    If oModelZZ5:IsDeleted()
      Loop
    EndIf

    nTotal += oModelZZ5:GetValue('ZZ5_TOTAL')


  Next
  
  oModelZZ4:LoadValue('ZZ4_TOTAL', nTotal)

  FwRestArea(aArea)
Return .T.
