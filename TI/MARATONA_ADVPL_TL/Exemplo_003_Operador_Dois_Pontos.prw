#Include "Totvs.ch"


/*/{Protheus.doc} zEx003
(long_description)
@type user function
@author Fernando Rodrigues
@since 27/03/2024
@version version
@param , , 
@return , , 
@example
(examples)
@see (links_or_references)
/*/
User Function zEx003()
	Local aArea := FwGetArea()
	Local oFont

	//Instancial uma classe na variavel oFont através do método New
	oFont := TFont():New('Arial', ,-16)

	//Acessando e modifigando um atributo
	FwAlertInfo("Conteudo do atributo negrito: " + cValToChar(oFont:Bold),"Antes")
	oFont:Bold := .T.
	FwAlertInfo("Conteudo do atributo negrito: " + cValToChar(oFont:Bold), "Depois")

	FwRestArea(aArea)
Return
