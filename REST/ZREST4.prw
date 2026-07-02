#Include "Totvs.ch"


Function U_ZREST4()
    Local aArea         := fwGetArea()
    Local cUsrLogin     := AllTrim(SuperGetMv("MV_X_WSUSR", .F., "Admin"))
    Local cUsrPassword  := AllTrim(SuperGetMv("MV_X_WSPAS", .F., "99"))
    Local cBearerAut    := fBearer(cUsrLogin, cUsrPassword)
    Local aHeader        := Array(0)
    Local cUrl          := "https://erp:2200/api/zWSProdutos"
    Local oRestClient   

    If ! empty(cBearerAut)
        oRestClient   := fwRest():new(cUrl)

        aAdd(aHeader, 'Authorization: Bearer ' + cBearerAut)
    
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


Static Function fBearer(cUsrLogin, cUsrPassword)
    Local oRestToken
    Local cURL          := "https://erp:2200/api/api/oauth2/v1/"
    Local cToken        := ""
    Local aHeaders      := Array(0)
    Local jResponse     
    Default cUsrLogin    := "" 
    Default cUsrPassword := ""
    

    oRestToken := fwRest():new(cURL)

    oRestToken:setPath("token?grant_type=password&password=" + cUsrPassword + "&username=" + cUsrLogin)

    If oRestToken:Post(aHeaders)

        jResponse := JsonObject():new()
        jResponse:FromJson(oRestToken:cResult)

        cToken := IIF(ValType(jResponse["access_token"]) != "U", jResponse["access_token"], "")

    EndIF


Return cToken
