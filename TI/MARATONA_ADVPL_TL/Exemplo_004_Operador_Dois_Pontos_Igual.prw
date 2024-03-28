#Include "Totvs.ch"

/*/{Protheus.doc} zEx004
(long_description)
@type user function
@author Fernando Rodrigues
@since 27/03/2024
@version 
@param , , 
@return , , 
@example
(examples)
@see (links_or_references)
/*/
User Function zEx004()
	Local aArea := FwGetArea()
	Local nValor
	Local nValor2 As Numeric

	nValor := 10
	nValor2 := 15

	FwAlertInfo("Apos primeira atribuicao ", "Atenção")

	nValor := "aaaa"

	FwAlertInfo("Apos primeira atribuicao ", "Atenção")

	FwRestArea(aArea)
Return
