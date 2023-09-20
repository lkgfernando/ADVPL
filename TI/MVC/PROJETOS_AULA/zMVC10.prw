#Include "Totvs.ch"
#Include "FwMVCDef.ch"


/*/{Protheus.doc} User Function zMVC010
    (long_description)
    @type  Function
    @author Fernando rodrigues
    @since 20/09/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zMVC010()
    Local aArea := FwGetArea()
    Local cFunBkp := FunName()


    dbSelectArea('SA2')
    SA2->(dbSetOrder(1))

    If SA2->(dbSeek(FWxFilial('SA2')+ "000005" ))
        SetFunName("MATA020")
        FWExecView('Visualizacao Teste', 'MATA020', MODEL_OPERATION_VIEW)
        SetFunName(cFunBkp)

    EndIf

    FwRestArea(aArea)
Return 
