#INCLUDE 'PROTHEUS.CH'


/*
// ##############################################################################################
// Projeto: EXERCICO DE AULA DE DECISÃO
// Modulo : FULL
// Fonte  : zDecisao
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 21/06/2022   | FERNANDO RODRIGUES   | APENAS PARA FINS EDUCACIONAIS
// -------------+----------------------+---------------------------------------------------------*/


User Function zDecisao()
    Local nNumero := 0
    Local nCount := 0
    Local lContinua := .T.

    while lContinua == .T.
        nCount ++

        if nCount == 10
            lContinua := .F.
        endif
        
    end

    for nNumero := 0 to 10
        nNumero ++

        if nNumero == 7
            exit
        endif

    next

Return
