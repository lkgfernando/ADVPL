#Include "Totvs.ch"


/*/{Protheus.doc} LOGI001
(Estudo logica calculando média)
@type user function
@author Fernando Rodrigues
@since 12/05/2024
@version 12/
@param , , 
@return , , 
@example
(examples)
@see (links_or_references)
/*/
User Function LOGI001()
  Local aArea := FwGetArea()
  Local nNota1 := 6
  Local nNota2 := 9
  Local nMedia := 0

  nMedia := (nNota1 + nNota2) / 2


  FwAlertInfo("Sua média é :" + cValToChar(nMedia), "Média")


  FwRestArea(aArea)
Return 
