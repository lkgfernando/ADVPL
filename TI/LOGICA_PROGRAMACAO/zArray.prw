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
User Function zArray()
    Local aArea   := GetArea()
    Local aFunct1 :={"Pedro"  , 32, .T.}
    Local aFunct2 :={"Maria"  , 22, .T.}
    Local aFunct3 :={"Antonio", 42, .F.}

    Alert("Nome: " + aFunct1[FUNCT_NAME] + CRLF + "Idade: " + cValToChar(aFunct1[FUNCT_IDADE]) )
    Alert(aFunct2[FUNCT_NAME])
    Alert(aFunct3[FUNCT_NAME])


    RestArea(aArea)    
Return 
