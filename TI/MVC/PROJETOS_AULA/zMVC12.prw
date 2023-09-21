#Include "Totvs.ch"
#Include "FWMVCDef.ch"


/*/{Protheus.doc} User Function zMVC12
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 21/09/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zMVC12()
    Local aArea := FWGetArea()
    Local aDados := {}
    Private aRotina := FWLoadMenuDef("zMVC01")
    Private oModel := FWLoadModel("zMVC01")
    Private lMsErroAuto := .F.

    aAdd(aDados, {"ZD1_CODIGO",      GetSXENum("ZD1", "ZD1_CODIGO") , Nil })
    aAdd(aDados, {"ZD1_NOME",        "SO PRA CONTRARIA"             , Nil })
    aAdd(aDados, {"ZD1_DTFORM",        cToD("03/03/1989")             , Nil })
    aAdd(aDados, {"ZD1_OBSERV",      "OBSERVACAO TESTE EXECAUTO 2"  , Nil })
    ConfirmSX8()

    lMsErroAuto := .F.

    FWMVCRotAuto( ;
                oModel,;
                "ZD1", ;
                MODEL_OPERATION_INSERT,;
                {{"ZD1MASTER", aDados}} ;
                )

    If lMsErroAuto

        MostraErro()
    
    Else

        MsgInfo("Registro incluido!", "Atenção")
    
    EndIf

    FWRestArea(aArea)
Return 
