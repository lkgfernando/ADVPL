#INCLUDE "PROTHEUS.CH"

/*
// ##############################################################################################
// Projeto: Exempolo de regua com RptStatus
// Modulo : SIGAATF
// Fonte  : zPBRpt
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 01/08/2022   | FERNANDO RODRIGUES   | IRÁ MOSTRAR A FUNCIONALIDADE DO RPTSTATUS
// -------------+----------------------+---------------------------------------------------------*/
User Function zPBRpt()
    Local aSay := {}
    Local aButton := {}
    Local nOpc := 0
    Local cTitulo := "Exemplo de Função"
    Local cDesc1 := "Estre programa exemplifica a utilização da função Processa() em conjunto"
    Local cDesc2 := "com as funções de incremento ProcRegua() e IncProc()"

    Aadd( aSay, cDesc1)
    Aadd( aSay, cDesc2)
    Aadd( aButton, { 1, .T., {|| nOpc := 1, FechaBatch() }} )
    Aadd( aButton, { 2, .T., {|| FechaBatch() }} )
    FormBatch( cTitulo, aSay, aButton)
    If nOpc <> 1
        Return
    EndIf

    RptStatus({|lEnd|RunProc(@lEnd)}, "Aguarde...", "Executando rotina.", .T.)

Return

Static Function RunProc(lEnd)
    Local nCnt := 0
    Local cCancel := "Cancelado pelo usuario"

    DbSelectArea("SX5")
    DbSetOrder(1)
    DbSeek(xFilial("SX5") + "01", .T.)
    While !Eof() .And. X5_FILIAL == xFilial("SX5") .And. X5_TABELA <= "99"
        nCnt++
        DbSkip()
    End

    SetRegua(nCnt)

    DbSeek(xFilial("SX5") + "01", .T.)

    While !Eof() .And. X5_FILIAL == xFilial("SX5") .And. X5_TABELA <= "99"
        IncRegua()
        If lEnd 
            MsgInfo(cCancel, "Fim")
        EndIf
        DbSkip()
    End
Return
