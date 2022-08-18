#INCLUDE "PROTHEUS.CH"

/*
// ##############################################################################################
// Projeto: Funcionalidade da fun��o MsgRun()
// Modulo : SIGAATF
// Fonte  : zPBMsgRun
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 05/08/2022   | FERNANDO RODRIGUES   | EXEMPLO DA FUNCIONALIDADE DO MSGRUN
// -------------+----------------------+---------------------------------------------------------*/

User Function zPBMsgRun()
    Local nCnt := 0

    DbSelectArea("SX1")
    DbGoTop()
    MsgRun("Lendo arquivo, aguarde.....", "T�tulo opcional", { ||dbEval({|x| nCnt++}) })
    MsgInfo("FIM!!!, Total de " + AllTrim(Str(nCnt)) + " registros", FunName())
Return
