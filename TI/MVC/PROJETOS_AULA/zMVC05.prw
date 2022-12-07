#Include "Totvs.ch"
#Include "FWMVCDef.ch"


/*/{Protheus.doc} User Function zMVC05
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 07/12/2022
/*/
User Function zMVC05()
    Local aArea := FWGetArea()
    Local aPergs := {}
    Local dDatDe := FirstDate(Date())
    Local dDatAt := LastDate(Date())

    aAdd(aPergs, {1, "Data De", dDatDe, "", ".T.", "", ".T.", 80, .F.})
    aAdd(aPergs, {1, "Data Até", dDatAt, "", ".T.", "", ".T.", 80, .T.})
    
    If ParamBox(aPergs, "Informe os parametros")
        If dDatAt >= dDatDe
            Processa({|| U_fPsCot01()})
        else
            MsgStop("Data Até deve ser maior ou igual a Data De", "Atenção")
        EndIf
    EndIf
    FWRestArea(aArea)
Return

/*/{Protheus.doc} User Function fPsCot01
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 07/12/2022
    @version 1.0
/*/
User Function fPsCot01()
    Local cQryZC1 := ""
    
    
Return 

