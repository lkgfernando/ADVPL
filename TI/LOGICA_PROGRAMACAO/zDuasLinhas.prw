#Include "Totvs.ch"

/*/{Protheus.doc} User Function zDuasLinhas
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 01/03/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zDuasLinhas()
    // Local aArea := FWGetArea()
    Local nX := 0
    Local nY := 0

    @ 00, 00 PSAY nX := 10
    @ 00, 00 PSAY nY := 20

    Alert(cValToChar(nX) + " ---- " + cValToChar(nY))
    Alert(cValToChar((nX := 15, nY := 30)))

   
    // FWRestArea(aArea)
Return 
