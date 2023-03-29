#Include "Totvs.ch"

/*/{Protheus.doc} User Function zExpUsr
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
User Function zExpUsr()
    Local aArea := FWGetArea()
    Local aAcessos := GetAccessList()
    Local cDescri := ""

    cDescri := aAcessos[2] 


    MsgInfo(cDescri)


    FWRestArea(aArea)
Return 
