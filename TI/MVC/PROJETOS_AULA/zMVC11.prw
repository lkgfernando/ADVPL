#Include "Totvs.ch"
#Include "FWMVCDef.ch"


/*/{Protheus.doc} User Function zMVC11
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 20/09/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zMVC11()
    Local aArea      := FWGetArea()
    Local lWorkedOut := .F.
    Local oModel
    Local oZD1Mod
    Local aError     := {}

    dbSeletcArea('ZD1')

    oModel := u_z01Model()
    oModel:SetOperation(3)
    oModel:Activate()



    FWRestArea(aArea)
Return 
