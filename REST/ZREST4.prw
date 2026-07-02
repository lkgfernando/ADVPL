#Include "Totvs.ch"


Function U_ZREST3()
    Local aArea         := fwGetArea()
    Local cUsrLogin     := AllTrim(SuperGetMv("MV_X_WSUSR", .F., "Admin"))
    Local cUsrPassword  := AllTrim(SuperGetMv("MV_X_WSPAS", .F., "99"))
    Local cBearerAut    := fBearer(cUsrLogin, cUsrPassword)
    Local aHeader        := Array(0)
    Local cUrl          := "https://erp:2200/api/zWSProdutos"
    Local oRestClient   

    If ! empty(cBearerAut)
        oRestClient   := fwRest():new(cUrl)

        aAdd(aHeader, 'Authorization: Basic ' + cBearerAut)
    
        oRestClient:setPath("/get_id?id=14.14002")

        If oRestClient:Get(aHeader)

            ShowLog(oRestClient:cResult)
        Else
            cLastError      := oRestClient:GetLastError()
            cErrorDetail    := oRestClient:GetResult()
            Alert(cErrorDetail)
        EndIF
    EndIF

    fwRestArea(aArea)
Return
