#Include "Totvs.ch"


/*/{Protheus.doc} zEx002
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
User Function zEx002()
	Local aArea := FwGetArea()
	Local nVar := 10
	Local cTeste := "'Aaaa' + 'Bbbb'"
	Local cProgr := "FwAlertInfo"

	//Mostra o conteudo da variavel com macro substituição
	FwAlertInfo(&cTeste, "& Apenas variável")

	//Executando a função
	&cProgr.("KL Solutions", "& Apenas o programa")

	//Executando a operação inteira
	&("FwAlertInfo('Mensagem de Teste', '& Expressao inteira')")

	FwRestArea(aArea)
Return
