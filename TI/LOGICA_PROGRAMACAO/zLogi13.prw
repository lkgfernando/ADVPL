#Include "Totvs.ch"

/*/{Protheus.doc} User Function zLogi13
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 21/02/2023
    @version 1.0
    @param , ,
    @return , ,
    @example
    (examples)
    @see (links_or_references)
/*/
User Function zLogi13()
	Local aArea := GetArea()
	Local nAtual := 0
	Local aNomes := {}
	Local cPares := ""
	Local cMsg := ""

    For nAtual := 1 To 10

        If nAtual % 2 == 0
            cPares += cValToChar(nAtual) + ", "
        EndIf

    Next
    
    aAdd(aNomes, "Fernando")
    aAdd(aNomes, "Kauan")
    aAdd(aNomes, "Livia Maria")
    aAdd(aNomes, "Glacieli")

    For nAtual := Len(aNomes) To 1 Step -1

        cMsg += "[" + cValToChar(nAtual) + "]" + aNomes[nAtual] + CRLF
    
    Next

    MsgInfo("Pares: " + cPares + CRLF + " Nomes: " + cMsg, "Logica Programação")

	RestArea(aArea)
Return
