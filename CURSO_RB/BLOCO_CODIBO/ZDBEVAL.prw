#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'MSMGADD.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TBICODE.CH'


/*
// ##############################################################################################
// Projeto: Exemplo de teste para a funcao DbEval()
// Modulo : 
// Fonte  : zDbEval01
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 24/06/2022   | Fernando Rodrigues   | Para fins educacionais
// -------------+----------------------+---------------------------------------------------------*/

User Function zDbEval()
    Local aArea := GetArea()
    Local cTab := "12"
    Local nCnt :=  0
    RpcSetType(3)
    PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
    
    DbSelectArea("SX5")
    DbSetOrder(1)
    DbGoTop()
    While !Eof() .And. X5_FILIAL == xFilial("SX5") .And. X5_TABELA <= cTab
        nCnt++
        DbSkip()
    EndDo

    DbSelectArea("SX5")
    DbSetOrder(1)
    DbGoTop()

    DbEval( { |x| nCnt++ },,{ ||X5_FILIAL == xFilial("SX5") .And. X5_TABELA <= cTab } )

    RESET ENVIRONMENT

    RestArea(aArea)
Return
