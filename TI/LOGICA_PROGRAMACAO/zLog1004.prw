#Include "Totvs.ch"

/*/{Protheus.doc} User Function zLog1004
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 21/02/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see https://www.beecrowd.com.br/judge/pt/problems/view/1004
    
    /*/
User Function zLog1004(nEnt1,nEnt2,cProd)
	Local aArea   := GetArea()
	Local nNum1   := nEnt1
	Local nNum2   := nEnt2
	Local cResult := ""
	Local nProd


    Iif(cProd == "+", nProd := nNum1 + nNum2, nProd)
	Iif(cProd == "*", nProd := nNum1 * nNum2, nProd)
	Iif(cProd == "-", nProd := nNum1 - nNum2, nProd)
	Iif(cProd == "/", nProd := nNum1 / nNum2, nProd)

    If nProd != 0 
	    cResult := "PROD = " + cValToChar(nProd)
    else
        cResult := "Operação informado está incorreta"
    EndIf
    MsgInfo(cResult)
	RestArea(aArea)
Return
