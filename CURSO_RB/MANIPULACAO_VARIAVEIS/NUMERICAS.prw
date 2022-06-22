#INCLUDE "PROTHEUS.CH"

/*
// ##############################################################################################
// Projeto: Manipula��o de variaveis num�ricas
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
    LOCAL cTitle := "Manipua��o de Variavel"

    nResultado := Round(nNumero / 2, 3)

    MsgAlert(cValToChar(nResultado), cTitle)

Return 
