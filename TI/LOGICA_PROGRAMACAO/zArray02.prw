#Include "Totvs.ch"


#Define FUNCT_NAME 1
#Define FUNCT_IDADE 2
#Define FUNCT_CASADO 3

/*/{Protheus.doc} User Function zArray
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
User Function zArray02()
    Local aArea   := GetArea()
    Local aFunct1 :={"Pedro"  , 32, .T.}
    Local aFunct2 :={"Maria"  , 22, .T.}
    Local aFunct3 :={"Antonio", 42, .F.}
    Local aFuncts := {}
    Local nCount  := 0

    aAdd(aFuncts, aFunct1)
    aAdd(aFuncts, aFunct2)
    aAdd(aFuncts, aFunct3)
    
    For nCount := 1 To Len(aFuncts)

        Alert(aFuncts[nCount, FUNCT_NAME], "Atenção")
        MsgInfo(aFuncts[nCount][FUNCT_NAME])

    Next nCount

    RestArea(aArea)    
Return 
