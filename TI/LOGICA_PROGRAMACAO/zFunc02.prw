#Include "Totvs.ch"

/*/{Protheus.doc} User Function zFunc02
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 09/02/2023
  @version 1.0
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function zFunc02()
  Local aArea := GetArea()
  Local nNum01 := 10.568999888

  Alert("NoRound(): " + cValToChar(NoRound(nNum01, 5)), "Manipulação de variáveis Numéricas")
  Alert("Round(): " + cValToChar(Round(nNum01, 5)), "Manipulação de variáveis Numéricas")
  RestArea(aArea)
Return 
