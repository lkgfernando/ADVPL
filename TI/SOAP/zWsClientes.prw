#Include "Totvs.ch"
#Include "APWebSrv.ch"
#Include "TopConn.ch"




WsService zWSClientes Description "Web service with client functions"

    WsData cViewRece as String
    WsData cViewSend as String
    WsData cNewRece as String
    WsData cNewSend as String

    WsMethod ViewCli        Description "View client data"
    WsMethod NewCli         Description "Create new client"

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

    fwRestArea(aArea)

Return lRet


WsMethod NewCli WsReceive cNewRece WsSend cNewSend WsService zWSClientes
    Local aArea     := fwGetArea()
    Local lRet      := .T.
    Local jJsonRece 
    Local cError    := ""
    Local jResponse := JsonObject():New()
    Local cDirLog   := '\x_logs\'
    Local nLinha    
    Local aDados    := {}
    Private lMsHelpAuto     := .T.
    Private lAutoErrNofile  := .T.
    Private lMsErroAuto     := .F.

    jJsonRece := JsonObject():New()
    cError    := jJsonRece:FromJson(::cNewRece)

    If ! Empty(cError) .Or. Len(::cNewRece) < 20
        jResponse['errorId'] := 'NEW001'
        jResponse['error']   := 'Parse do Json'
        jResponse['solution']:= 'Erro ao fazer o Parse do JSON'

    Else

        If Empty(jJsonRece:GetJsonObject('cnpj'))        .Or. ;
            Empty(jJsonRece:GetJsonObject('nome'))      .Or. ;
            Empty(jJsonRece:GetJsonObject('nReduz'))    .Or. ;
            Empty(jJsonRece:GetJsonObject('tipo'))      .Or. ;
            Empty(jJsonRece:GetJsonObject('end'))       .Or. ;
            Empty(jJsonRece:GetJsonObject('mun'))       .Or. ;
            Empty(jJsonRece:GetJsonObject('est'))


            jResponse['errorId'] := 'NEW002'
            jResponse['error']   := 'Campo(s) obrigarorio(s)'
            jResponse['solution']:= 'Existem campos que não foram enviados, revise a estrutura do seu JSON'

        Else
            aAdd(aDados, {'A1_CGC'  ,jJsonRece:GetJsonObject('cnpj')     , Nil})
            aAdd(aDados, {'A1_NOME' ,jJsonRece:GetJsonObject('nome')    , Nil})
            aAdd(aDados, {'A1_NREUZ',jJsonRece:GetJsonObject('nReduz')  , Nil})
            aAdd(aDados, {'A1_TIPO' ,jJsonRece:GetJsonObject('tipo')    , Nil})
            aAdd(aDados, {'A1_END'  ,jJsonRece:GetJsonObject('end')     , Nil})
            aAdd(aDados, {'A1_MUN'  ,jJsonRece:GetJsonObject('mun')     , Nil}) 
            aAdd(aDados, {'A1_EST'  ,jJsonRece:GetJsonObject('est')     , Nil})

            MsExecAuto({|x,y| CRMA980(x,y)}, aDados, 3)

            If lMsErroAuto

                cErrorLog := ''
                aLogAuto  := GetAutGrLog()
                For nLinha := 1 To Len(aLogAuto)
                    cErrorLog += aLogAuto[nLinha] + CRLF
                Next nLinha

                cArqLog := 'zWSCliente_New_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.log'
                MemoWrite(cDirLog + cArqLog, cErrorLog)

                jResponse['errorId']    := 'NEW003'
                jResponse['error']      := 'Erro na inclusao do registro'
                jResponse['solution']   := 'Não foi possivel incluir registro, foi gerado um arquivo de log em' + cDirLog + cArqLog + ' '
            Else
                jResponse['note']    := 'Registro incluido com sucesso'

            EndIf

        EndIf


    EndIf



    ::cNewSend := jResponse:ToJson()
    fwRestArea(aArea)

Return lRet




