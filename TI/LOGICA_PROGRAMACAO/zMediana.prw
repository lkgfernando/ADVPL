#Include "Totvs.ch"

/*/{Protheus.doc} User Function zMediana
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 08/03/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zMediana()
    Local aArea   := FWGetArea()
    Local aArr    :={5, 13, 12, 3, 15, 17, 8, 15, 6, 16, 9}
    Local n       := 1 
    Local i       := 1 
    Local j       := 1
    Local nTmp    
    Local cMsg    := ""

    n := Len(aArr)

    While (i < n )
        While (j < n)
            if (aArr[j] > aArr[j + 1])
                nTmp         := aArr[j]
                aArr[j]     := aArr[j + 1]
                aArr[j + 1] := nTmp
            EndIf
            j++
        EndDo
        j := 1
        i++
    EndDo

    For i := 1 To Len(aArr)
        cMsg += "{ " + cValToChar(aArr[i]) + ", "
    Next
     cMsg += "}"

    MsgInfo(cMsg, "Atenção")

    FWRestArea(aArea)
Return 
