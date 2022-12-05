#Include "Totvs.ch"
#Include "TopConn.ch"



/*/{Protheus.doc} User Function FTOSIMP
    (Função para calcular total do pedido sem imposto calculo feito diretamente na SC6)
    @type  Function
    @author Fernando Rodrigues
    @since 02/12/2022
    @version 1.0
    @param numPdOrg
    @return valSImp
/*/
User Function FTOSIMP(nNumPdOrg)
    Local aArea := GetArea()
    Local aAreaZC1 := GetArea()
    Local cQrySC6 := ""
    Local nValSImp := 0
    Default nNumPdOrg := ZC1->ZC1_PEDIDO

    cQrySC6 := " SELECT "
    cQrySC6 += "    C6_ITEM,"
    cQrySC6 += "    C6_VALOR"
    cQrySC6 += " FROM "
    cQrySC6 += "    " + RetSqlName('SC6') + " SC6 "
    cQrySC6 += " WHERE "
    cQrySC6 += "    C6_ZZPDORG = '"+nNumPdOrg+"'"
    cQrySC6 += "    AND SC6.D_E_L_E_T_ <> '*'"
    cQrySC6 += " ORDER BY "
    cQrySC6 += "    C6_ITEM "
    TcQuery cQrySC6 New Alias "QRY_SC6" 

    QRY_SC6->(DbGoTop())
    While ! QRY_SC6->(Eof())

        nValSImp += QRY_SC6->C6_VALOR

        QRY_SC6->(DbSkip())
    EndDo

    QRY_SC6->(DbCloseArea())
    RestArea(aAreaZC1)
    RestArea(aArea)    
Return nValSImp
