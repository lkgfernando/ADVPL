#INCLUDE "PROTHEUS.CH"
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TBICODE.CH'

/*
// ##############################################################################################
// Projeto: zGravaDados ==> EXEMPLO DE GRAVAÇÃO UTILIZANDO BEGIN TRASACTION / END TRASACTION
// Modulo : SIGAATF
// Fonte  : zGravaDados
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 28/07/2022   | FERNANDO JRODRIGUES  | EXEMPLO DE GRAVAR DADOS NA SA1     
// -------------+----------------------+---------------------------------------------------------*/

User Function zGravaDados()
    Local cNumero
    Local xx
    PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
    
    DbSelectArea("SA1")
    DbSetOrder(1)

    BEGINTRAN()

    For xx := 1 to 9
        cNumero := GetSxeNum("SA1", "A1_COD")

        RecLock("SA1", .T.)
        A1_FILIAL := xFilial()
        A1_COD := cNumero
        A1_LOJA := "01"
        A1_CGC := "9161183000010" + cValToChar(xx)
        A1_PESSOA := "J"
        A1_NOME := "RAZAO TESTE PEDIDO" + cValToChar(xx)
        A1_NREDUZ := "RAZAO TESTE PEDIDO" + cValToChar(xx)
        A1_TIPO := "R"
        A1_END := "RUA FRANCISCO RODRIGUES, 81"
        A1_BAIRRO := "RECANTO DO ITAMARACA"
        A1_EST := "SP"
        A1_COD_MUN := "30706"
        A1_MUN := "MOGI GUACU"
        A1_CEP := "13844253"
        A1_TEL := "1911111111"
        A1_INSCR := "ISENTO"
        A1_EMAIL := "nfe@teste.com"
        A1_VEND := "000001"
        A1_NATUREZ := "0000000001"


        MsUnlock()
        ConfirmSx8()
    Next

    ENDTRAN()

    RESET ENVIRONMENT
Return
