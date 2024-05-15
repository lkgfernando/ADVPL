#Include "Totvs.ch"

/*/{Protheus.doc} ADVPL001
(long_description)
@type user function
@author Fernando Rodrigues
@since 10/05/2024
@version 12/
@param , , 
@return , , 
@example
(examples)
@see (links_or_references)
/*/
User Function ADVPL001()
	Local aArea := FwGetArea()
	// Local cVar01 := 'Essa щ uma variavel caracter'
	// Local nValor := 15
	// Local nNumero := 25
	// Local lOk := .F.
	// Local lContinua := .T.
	// Local nQuant := 0
	// Local i := 0
	// Local x := 0


	// MsgAlert(cVar01, 'Exemplo')

	// cVar01 += ' Concatenado variavel cVar01'


	// MsgAlert(cVar01, 'Exemplo')

//|+----------------------------------------------------------------
//| Condicionais
//|+----------------------------------------------------------------


	// If nValor > nNumero
	// 	FwAlertSuccess('O valor щ maior que: ' + cValToChar(nNumero), "Resultado")
	// ElseIf nValor > nNumero
	// 	FwAlertHelp("O valor щ maior que: " + cValToChar(nNumero), "Resultado")
	// Else
	// 	FWAlertError("O valor щ menor que: " + cValToChar(nNumero), "Resultado")
	// EndIf


	// lOk := IIF(nValor = 15, .T., .F.)

	// If lOk
	// 	FwAlertSuccess("Variavel щ verdadeira ", "lOk")
	// EndIf

//|+----------------------------------------------------------------
//| Case
//|+----------------------------------------------------------------
	// Do Case	
	// Case nNumero == 10
	// 	FwAlertSuccess("Valor informado щ igual a 10", "Case")
	// Case nNumero == 15
	// 	FwAlertSuccess("Valor informado щ igual a 15", "Case")
	// Case nNumero == 20
	// 	FwAlertSuccess("Valor informando щ igual a 20", "Case")
	// Case nNumero == 25
	// 	FwAlertSuccess("Valor informado щ igual a 25", "Case")
	// OtherWise
	// 	FwAlertHelp("Favor digite valro correto!!!", "Atenчуo")
	// EndCase

//|+----------------------------------------------------------------
//| While
//|+----------------------------------------------------------------

	// While lContinua
	// 	nQuant += 1

	// 	If nQuant > 50
	// 		lContinua := .F.
	// 	EndIf

	// EndDo

	// FwAlertInfo("Total percorrido foi: " + cValTochar(nQuant), "While")

	// nQuant := 0
	// For i := 1 To 50
	// 	nQuant++
	// 	If nQuant >= 5
	// 		nQuant += 5
	// 	EndIf
	// Next i

	// FwAlertInfo("Percorrido pelo For: " + cValToChar(nQuant), "FOR sem Step")

	// For x := 1 To 50 Step 2
		
	// 	If nQuant >= 10
	// 		nQuant += 5
	// 	EndIf

	// Next

	// FwAlertInfo("Pecorrido polo For: " + cValToChar(nQuant), "For com Step 2")

	


	FwRestArea(aArea)
Return
