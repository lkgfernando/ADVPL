#Include "Totvs.ch"

/*/{Protheus.doc} User Function zFunc03
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 12/02/2023
  @version 1.0
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function zFunc03()
	Local aArea    := GetArea()
	Local nAux     := 0
	Local nCnt     := 0
	Local nSomaPar := 0



	For nCnt := 0 To 100 Step 2
		nSomaPar += nCnt
	Next nCnt

	Alert("A soma dos números pares são: " + cValToChar(nSomaPar), "For Next")

	nSomaPar := 0

	While nAux <= 100

		nSomaPar += nAux
		nAux += 2
			
	EndDo

	MsgInfo("A soma dos números pares de 0 a 100 é: " + cValToChar(nSomaPar), "While EndDo")

	RestArea(aArea)
Return
