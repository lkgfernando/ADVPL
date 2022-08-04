#INCLUDE "PROTHEUS.CH"

/*
// ##############################################################################################
// Projeto: REGUA PROCESSA
// Modulo :
// Fonte  : zPBProc
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 01/08/2022   | FERNANDO RODRIGUES   | 
// -------------+----------------------+---------------------------------------------------------*/


User Function zPBProc()
    Local aSay    := {}
    Local aButton := {}
    Local nOpc    := 0
    Local cTitulo := "Exmplo de Funções"
    Local cDesc1  := "Utilização da função Processa()"
    Local cDesc2  := "em conjunto com as funções de incremento ProcRegua()"
    Local cDesc3  := "IncProc()"

    Aadd( aSay, cDesc1 )
    Aadd( aSay, cDesc2 )
    Aadd( aSay, cDesc3 )
    Aadd( aButton, { 1, .T., {|| nOpc := 1, FechaBatch() }} )
    Aadd( aButton, { 2, .T., {|| FechaBatch() }} )
    FormBatch( cTitulo, aSay, aButton )

    If nOpc <> 1
        Return
    EndIf

    Processa( {|lEnd| RunProc(@lEnd)}, "Aguarde...","Executando a rotina", .T.)


Return


Static Function RunProc(lEnd)
    Local nCnt := 0
    Local cCancel := "Cancelado pelo usuario"

    DbSelectArea("SX5")
    DbSetOrder(1)
    DbSeek(xFilial("SX5"+ "01", .T.))
    DbEval( {|x| nCnt++ },,{||X5_FILIAL == xFilial("SX5") .And. X5_TABELA <= "99"})

    ProcRegua(nCnt)

    DbSeek(xFilial("SX5") + "01", .T.)
    While !Eof() .And. X5_FILIAL == xFilial("SX5") .And. X5_TABELA <= "99"
        IncProc("Processando tabela: " + SX5->X5_CHAVE)
        If lEnd
            MsgInfo(cCancel, "Fim")
            Exit
        EndIf
        DbSkip()
    End

Return
