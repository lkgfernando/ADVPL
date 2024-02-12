#Include "Protheus.ch"
#Include "tlpp-core.th"

/*/{Protheus.doc} zExe001
(long_description)
@type user function
@author user
@since 11/02/2024
@version version
@param param_name, param_type, param_descr
@return return_var, return_type, return_description
@example
(examples)
@see (links_or_references)
/*/
User Function zExe001()
	Local aArea := FWGetArea()
	Local cLetra := "F"
	Local cNome := "FERNANDO"

	If cLetra $ cNome

		Alert("TESTE","TESTE")

	EndIf

	If Upper(cLetra) $ (cNome)

		FWAlertInfo("A letra está contida nome variáveis tudo maiúsculas", "Teste 1")

	EndIf

	FWRestArea(aArea)
Return
