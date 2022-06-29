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
    Local aArray1 := {0,0,0}
    Local aArray2 := {}
    Local aArray3 := ARRAY(3,3)
    Local nPos := 0
    Local nTamanho := 0



    while lContinua == .T.
        nCount ++
        
        aArray1[1] = nCount
        aArray1[2] = nCount / 2
        aArray1[3] = nCount ** 2

        if nCount == 10
            lContinua := .F.
        endif
        
    end

    for nNumero := 0 to 10
    

        aAdd(aArray2,{nNumero})

        if nNumero == 7
            exit
        endif

    next

    nTamanho := Len(aArray2)-1
    nPos := ASCAN(aArray2,{ | x | x[1] == 4 } )
    ADEL(aArray2, nPos)
    ASIZE(aArray2 , nTamanho)

Return
