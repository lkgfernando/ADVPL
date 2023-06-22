#Include "Totvs.ch"


/*/{Protheus.doc} User Function zVerifica
    (long_description)
    @type  Function
    @author Fernando José rodrigues
    @since 22/05/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zVerifica()
    Local aArea := FWGetArea()
    Local nGrupo := UsrRetGrp(__cUserID)
    Local aGroups := FWSFAllGrps()
    //Local cTipoVar := ValType(UsrRetGrp(__cUserID))
    Local lRet := IiF(UsrRetGrp()[1] == "000001" .OR. __cUserID == "000000", .T., .F.)


    Alert(lRet, "Atenção")

    IiF(UsrRetGrp()[1] == "000001" , .T., .F.)

    FWRestArea(aArea)
Return 
