#Include "Totvs.ch"

/*/{Protheus.doc} User Function zArray03
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 25/02/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zArray03()
    Local aArea := GetArea()
    Local nCnt := 0
    Local aX[10]
    //Local aY := Array(10)
    Local aZ := {}
    Local nSize := 5
    Local cMsg := ""

    For nCnt := 1 To 10
        aX[nCnt] := nCnt * nCnt
    Next nCnt

    For nCnt := 1 To Len(aX)
        cMsg += "[ " + cValToChar(nCnt) + " ] : " + cValToChar(aX[nCnt]) + CRLF
    Next nCnt
    cMsg += "<br />"
    cMsg += "<b>Tabuada " + cValTochar(nSize) + "</b>" + CRLF

    For nCnt := 1 To 10
        aAdd(aZ, nCnt * nSize)
        cMsg += cValToChar(nCnt) + " X " + cValToChar(nSize) + " = " + cValToChar(aZ[nCnt]) + CRLF
    Next nCnt

    MsgInfo(cMsg)

    RestArea(aArea)
Return 
