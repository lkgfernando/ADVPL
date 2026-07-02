#Include 'Totvs.ch'

/*/{Protheus.doc} ZREST01
Exemplo de consumo de Rest usantdo FWREST
@type user function
@author user
@since 02/07/2026

/*/
Function U_ZREST01()
    Local aArea         := fwGetArea()
    Local aHeader       := Array(0)
    Local oRestClient   := FWREST():New("https://viacep.com.br/ws")
    Local cCep           := "13163296"

    aAdd(aHeader, 'User-Agent: Mozilla/5.0 (compatible; Protheus)' + getBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=UTF-8')

    oRestClient:SetPath("/"+ cCep + "/json/")

    If oRestClient:Get(aHeader)

        ShowLog(oRestClient:cResult)
    
    Else
        cLastError := oRestClient:GetLastError()
        cErrorDetail := oRestClient:GetResult()
        Alert(cErrorDetail)

    EndIF

    fwRestArea(aArea)
    
Return 
