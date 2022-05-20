#Include 'Protheus.ch'
#Include 'Parmtype.ch'
#Include 'RestFul.ch'


WSRESTFUL helloword DESCRIPTION "Rest Hello World"

    WSDATA mensagem as STRING

    WSMETHOD GET DESCRIPTION "Metado get para Hello World" WSSYNTAX "/holloword/{}"

END WSRESTFUL


WSMETHOD GET WSRECEIVE mensagem  WSSERVICE helloword
    Local lRet := .T.
    Local oJson := JsonObject():New()
    Local cMsg := ""
        
    //Define um tipo de retorno do serviço
    ::setContentType("apllication/json")

    //Mensagem
    //cMsg := "Hello Word"
    Conout(cMsg)

    //Via query string
    If ValType(::mensagem) <> "U"
        cMsg += ::mensagem + " Via query string"
    EndIf

    //via paramentro de URL

    If Len(::aURLParms) > 0
        cMsg += ::aURLParms[1] + " Via paramentro de URL"
    EndIf

    //Objeto responsavel por  tratar os dados e gerar como json
    oJson["mensagem"] := cMsg

    //Retorna os dado no formato json
    cRet := oJson:ToJson()

    //Retorno do Serviço
    ::SetResponse(cRet)    

Return lRet
