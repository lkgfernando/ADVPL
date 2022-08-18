#INCLUDE "TOTVS.CH"

/*
// ##############################################################################################
// Projeto: FUNCIONAMENTO DA FUNÇÃO FWMSGRUN
// Modulo : SIGAATF
// Fonte  : zFwMsgrun
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 04/08/2022   | FERNANDO RODRIGUES   | EXEMPLO EDUCACIONAL
// -------------+----------------------+---------------------------------------------------------*/ 


User Function zFwMsgrun()
    Local oSay := NIL

    FwMsgRun(Nil, {|oSay| RunMessage(oSay)}, "Processing", "Starting process...")

Return


Static Function RunMessage(oSay)
    Local nX := 0

    //Simula a preparação para execução
    Sleep(2000)
    For nX := 1 To 10
        oSay:SetText("Working at:" + StrZero(nX, 6))
        ProcessMessage() //Força o descongelamento do smartclient

        Sleep(1000) //Simula o processamento da função

    Next nX
Return
