#Include "Totvs.ch"


/*/{Protheus.doc} U_ZREST2
    Exempo de consumo utilizando HttpGet
    @type  Function
    @author Fernando
    @since 02/07/2026

    /*/
Function U_ZREST2()
    Local aArea        := fwGetArea()
    Local cResult      := ""
    Local cCep         := "13163296"

    cResult := HttpGet(;
        "https://viacep.com.br/ws/" + cCep + "/json/";
        ,; // cGetParams
        ,; // nTimeout
        ,; // aHeadStr
        ;   // cHeaderGet
    )

    ShowLog(cResult)


    fwRestArea(aArea)
Return 
