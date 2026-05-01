#Include "Totvs.ch"
#Include "APWEbSrv.ch"


WsService zWSTestSoap Description "WebService com funções de Teste"

        WsData cTstRece    as String
        WsData cTstSend    as String

        WsMethod TstServ   Description "Metodo para testar se serviço está em funcionamento"

EndWsService



WsMethod TstServ WsReceive cTstRece WsSend cTstSend WsService zWSTestSoap
    ::cTstSend := "Esta funcionando - Data " + dToC(Date()) + " Hora " + Time()
Return .T.
