#Include "Totvs.ch"
#Include "APWebSrv.ch"
#Include "TopConn.ch"




WsService zWSClientes Description "Web service with client functions"

    WsData cViewRece as String
    WsData cViewSend as String
    WsData cNewRace as String
    WsData cNewSend as String

    WsMethod ViewCli        Description "View client data"
    //WsMethod NewCli         Description "Create new client"

EndWsService


/*/{Protheus.doc} WsMethod ViewCli
    (long_description)
    @type  Function
    @author Fernando
    @since 29/03/2026

    /*/
WsMethod ViewCli WsReceive cViewRece WsSend cViewSend WsService zWSClientes

    Local aArea     := fwGetArea()
    Local lRet      := .T.
    Local cBusca    := AllTrim(::cViewRece)
    Local nIndice   := 0
    Local cCGC      := ""
    Local cMascCpf  := "@R 999.999.999-99"
    Local cMascCnpj := "@R 99.999.999/9999-99"

    cBusca := StrTran(cBusca, ".", "")
    cBusca := StrTran(cBusca, "-", "")
    cBusca := StrTran(cBusca, "/", "")

    If Len(cBusca) = 14 .Or. Len(cBusca) = 11 
        nIndice := 3 // A1_FILIAL+A1_CGC
    Else
        nIndice := 1 // A1_FILIAL+A1_COD
    EndIf

    RpcSetEnv("99","01")

    DBSelectArea("SA1")
    SA1->(dbSetOrder(nIndice))
    If SA1->(msSeek(fwxFilial("SA1") + cBusca))
        cCGC := AllTrim(SA1->A1_CGC)

        ::cViewSend := '{' + CRLF
        ::cViewSend += '    "dados":{' + CRLF
        ::cViewSend += '  "status":"Cliente encontrado", ' + CRLF
        ::cViewSend += '  "codigo":"' + SA1->A1_COD + SA1->A1_LOJA + '", ' + CRLF
        If(Len(cCGC) = 14)
            ::cViewSend += '  "cnpj":"' + AllTrim(Transform(cCGC, cMascCnpj)) + '", ' + CRLF
        Else
            ::cViewSend += '  "cpf":"' + AllTrim(Transform(cCGC, cMascCpf)) + '", ' + CRLF
        EndIf
        ::cViewSend += '    "nome":"' + AllTrim(SA1->A1_NOME) + '", ' + CRLF
        ::cViewSend += '    "email":"' + AllTrim(SA1->A1_EMAIL) + '", ' + CRLF
        ::cViewSend += '    "site":"' + AllTrim(SA1->A1_HPAGE) + '"' + CRLF
        ::cViewSend += '    }' + CRLF
        ::cViewSend += '}' + CRLF
    Else
        ::cViewSend := '{' + CRLF
        ::cViewSend += '    "dados":{' + CRLF
        ::cViewSend += '  "status":"Cliente não encontrado"' + CRLF
        ::cViewSend += ' }' + CRLF
        ::cViewSend += '}' + CRLF
    EndIf

    SA1->(dbCloseArea())

    RpcClearEnv()

    fwRestArea(aArea)

Return lRet




