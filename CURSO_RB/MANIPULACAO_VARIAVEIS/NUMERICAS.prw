#INCLUDE "PROTHEUS.CH"

/*
// ##############################################################################################
// Projeto: Manipulação de variaveis numéricas
// Modulo : SIGAATF
// Fonte  : zNumericas
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 17/06/2022   | Fernando Rodrigues   | Apenas para fins educacionais          
// -------------+----------------------+---------------------------------------------------------*/


User Function zNumericas()
    LOCAL nNumero := 13
    LOCAL nResultado := 0
    LOCAL cTexto := ""
    LOCAL aArray := {}
    LOCAL cTitle := "Manipuação de Variavel"

    nResultado := Round(nNumero / 2, 3)

    MsgAlert(cValToChar(nResultado), cTitle)

Return 
