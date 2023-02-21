#Include "Totvs.ch"

/*/{Protheus.doc} User Function zLogi12
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 16/02/2023
  @version 1.0
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function zLogi12()
	Local aArea    := GetArea()
	Local nMesAtu  := Month(Date())
	Local nMesAniv := 3
	Local cMsg     := ""

	cMsg := Iif(nMesAtu == nMesAniv, "Aniversariante", "Ainda n�o � seu m�s de anivers�rio")

	Alert(cMsg)

	RestArea(aArea)
Return
