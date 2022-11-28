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
