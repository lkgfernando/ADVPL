#Include "Totvs.ch"


/*/{Protheus.doc} User Function zListExpre
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 15/04/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zListExpre()
    Local aArea := FWGetArea()
    Local aA := {"GARY HALL", "FRED SMITH", "TIM HONES"}
    //Local aB := {}
    Local nX := 1
    Local nY := 2
    Local bBloco := {|nX, nY| SubStr(nX, At("", nX) + 1) > SubStr(nY, At("", nY) + 1)}

    aSort(aA, bBloco)


    MsgInfo( aA + CRLF + bBloco, "Atenção" )
    

    


    FWRestArea(aArea)
Return
