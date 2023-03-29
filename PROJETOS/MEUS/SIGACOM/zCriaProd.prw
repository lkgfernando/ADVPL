#Include "Totvs.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function zCriaProd
    (Gatilho para criar código de produto ex: tipo de produto + grupo + sequência PA.1000.0001)
    @type  Function
    @author Fernando José Rodrigues
    @since 25/03/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zCriaProd()
    Local aArea    := FWGetArea()
    Local cQrySB1  := ""
    Local cCodProd := ""
    Local cTipo := M->B1_TIPO
    Local cGrupo := M->B1_GRUPO
    Local cNumSeq := ""
    Local nTamanho := 4

    
    cQrySB1 := " SELECT " + CRLF
    cQrySB1 += "    B1_FILIAL," + CRLF
    cQrySB1 += "    B1_COD,  " + CRLF
    cQrySB1 += "    B1_TIPO, " + CRLF
    cQrySB1 += "    B1_GRUPO " + CRLF
    cQrySB1 += " FROM " + CRLF
    cQrySB1 += "    " + RetSQLName('SB1') + CRLF
    cQrySB1 += " WHERE " + CRLF
    cQrySB1 += "    B1_FILIAL = '" + xFilial("SB1") + "' " + CRLF
    cQrySB1 += "    AND B1_TIPO = '" + cTipo + "' " + CRLF
    cQrySB1 += "    AND B1_GRUPO = '" + cGrupo + "' " + CRLF
    cQrySB1 += "    AND D_E_L_E_T_ != '*' "

    TCQUERY cQrySB1 new Alias "QRYSB1"
    MemoWrite("QUERY_SBN.SQL", cQrySB1)

    Count To nSeq

    nSeq += 1
    
    cNumSeq := PadL(nSeq, nTamanho, '0')

    cCodProd := cTipo + "." + cGrupo + "." + cNumSeq

    M->B1_COD := cCodProd

    QRYSB1->(DbCloseArea())
    
    FWRestArea(aArea)
Return M->B1_COD
