#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TBICODE.CH'


/*
// ##############################################################################################
// Projeto: zParametro ==> Gravação de data em um parâmetro
// Modulo : SigaATF
// Fonte  : zParametro
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 28/07/2022   | FERNANDO RODRIGUES   | FUNÇÃO PARA ESTUDOS
// -------------+----------------------+---------------------------------------------------------*/

User Function zParametro()
    Local dParm := ""
    If SELECT("SX6") > 0
        MsgAlert("Protheus Aberto", cTitle)

    else
        RpcSetType(3)
        PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"

    endIf

        dParm := GetMv("MV_ULMES") + 90

        PutMv("MV_ULMES", dParm)

        MsgInfo(Dtoc(GetMv("MV_ULMES")), "MANIPULADNO PARAMETRO")

        RESET ENVIRONMENT
Return 
