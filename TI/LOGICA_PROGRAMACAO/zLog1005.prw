#Include "Totvs.ch"



/*/{Protheus.doc} User Function zLog1005
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 23/02/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zLog1005(nA,nB)
    Local aArea := GetArea()
    Local nPesoA := 3.5
    Local nPesoB := 7.5
    Local nNotaA := nA * nPesoA
    Local nNotaB := nB * nPesoB
    Local nMedia := (nNotaA + nNotaB) / (nPesoA + nPesoB)

    MsgInfo("MEDIA: " + cValToChar(nMedia))


    RestArea(aArea)
Return 
