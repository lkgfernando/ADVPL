#Include "Totvs.ch"

#Define N_PESO_A 2
#Define N_PESO_B 3
#Define N_PESO_C 5
/*/{Protheus.doc} User Function zLog1006
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 27/02/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zLog1006(nA, nB, nC)
    Local aArea  := GetArea()
    Local nNotaA := nA * N_PESO_A
    Local nNotaB := nB * N_PESO_B
    Local nNotaC := nC * N_PESO_C
    Local nPSoma := N_PESO_A + N_PESO_B + N_PESO_C
    Local nMedia := (nNotaA + nNotaB + nNotaC) / nPSoma
    Local cMsg   := ""

    cMsg += "<table>" + CRLF
    cMsg += "<tr><td> MÉDIA " + cValToChar(nMedia) + "</td></tr>" + CRLF
    cMsg += "</table>" + CRLF


    MsgInfo(cMsg)


    RestArea(aArea)
Return 
