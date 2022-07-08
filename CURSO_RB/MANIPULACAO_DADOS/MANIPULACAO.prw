#INCLUDE "PROTHEUS.CH"
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TBICODE.CH'


/*
// ##############################################################################################
// Projeto: zManipu -> irá fazer inclusão na tabela SZ1
// Modulo : SIGAATF
// Fonte  : zManipu
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 08/07/2022   | FERNANDO RODRIGUES   | APENAS PARA FINS EDUCACIONAIS
// -------------+----------------------+---------------------------------------------------------*/

User Function zManipu()
    Local aArea := GetArea()
    Local cCliente := "000001"
    Local cProduto := "1011"
    Local cLoja := "01"
    RpcSetType(3)
    // PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"

    DbSelectArea("SZ1")
    DbSetOrder(1)

    if DbSeek(xFilial()+cCliente+cLoja)

        MsgAlert("Registro Encontrado", "Teste RecLock") 

        RecLock("SZ1", .F.)
        Z1_FATOR := 6
        MsUnlock()

    else
        RecLock("SZ1", .T.)
        Z1_FILIAL := xFilial()
        Z1_CLIENT := "000001"
        Z1_LOJA   := "01"
        Z1_PRODUT := "1011"
        Z1_UM     := "UN"
        Z1_UMCLI  := "CX"
        Z1_TIPO   := "M"
        Z1_FATOR  := 6
        MsUnlock()

    EndIf

    If MsgYesNo("Deseja excluir o registro da tabela SZ1", "Atenção", "YESNO")
        DbSelectArea("SZ1")
        DbSetOrder(1)
        If DbSeek(xFilial()+cCliente+cLoja)
            RecLock("SZ1", .F.)
            DBDELETE()
            MsUnlock()
        EndIf
    EndIf

    DbSelectArea("SA1")
    DbSetOrder(1)
    If DbSeek(xFilial()+cCliente+cLoja)
        MsgInfo("Client:" + SA1->A1_NOME, "Nome do cliente")
    EndIf

    DbSelectArea("SB1")
    DbSetOrder(1)
    If DbSeek(xFilial()+cProduto)
        MsgInfo("Produto:" + SB1->B1_DESC, "Descrição do Produto")
    EndIf

    RestArea(aArea)
    // RESET ENVIRONMENT

    
Return


