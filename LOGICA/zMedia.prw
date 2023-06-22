#Include "Totvs.ch"

/*/{Protheus.doc} User Function zMedia
    (long_description)
    @type  Function
    @author Fernando Jos� Rodrigues
    @since 25/05/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zMedia()
    Local aArea     := FWGetArea()
    Local aMedia    := {8.0,7.0,8.0,8.0,7.0,7.0}
    Local nSomaNota := 0
    Local nMedia    := 0
    Local i         := 0


    For i := 1 To Len(aMedia)

        nSomaNota += aMedia[i]
        
    Next i

    nMedia := nSomaNota / Len(aMedia)

    Alert("A m�dia da sala �: "+ cValtoChar(nMedia), "Aten��o")

    FWRestArea(aArea)
Return 
