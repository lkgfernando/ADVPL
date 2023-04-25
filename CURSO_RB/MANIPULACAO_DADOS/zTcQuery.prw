#Include "Totvs.ch"
#Include "TopConn.ch"
#Include "Tbiconn.ch"
#Include "TbiCode.ch"


/*/{Protheus.doc} User Function zTcQuery
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 20/04/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zTcQuery()
    Local cAliasFor
    Local cSql := ""
    Local nRec := 0


    If SELECT("SX6") > 0
        Alert("Protheus Aberto")
    Else
        RpcSetType(3)
        PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"
    EndIf
    
    cAliasFor := GetNextalias()

    cSql := " SELECT " + CRLF
    cSql += " A2_COD, " + CRLF
    cSql += " A2_LOJA, " + CRLF
    cSql += " A2_NREDUZ, " + CRLF
    cSql += " A2_EST, " + CRLF
    cSql += " A2_MSBLQL, " + CRLF
    cSql += " A2_ULTCOM " + CRLF
    cSql += " FROM " + CRLF
    cSql += " " + RetSqlName("SA2") + " " + CRLF
    cSql += " WHERE " + CRLF
    cSql += "   A2_FILIAL = '" + xFilial("SA2") + "' " + CRLF
    cSql += "   AND D_E_L_E_T_ <> '*' " + CRLF

    MemoWrite("AULA_QUERY.SQL", cSql)

    TCQUERY (cSql) ALIAS ( cAliasFor) NEW

    TCSetField(cAliasFor, "A2_ULTCOM", "D")


    Count To nRec

    If nRec == 0

        Alert("Não foram encontrados dados, verifique se há cadastro ou sua consulta está incorreta!", "Atenção")
        DbSelectArea(cAliasFor)
        DbCloseArea()
        Return

    EndIf     


    DbSelectArea(cAliasFor)
    DbGotop()

    While !Eof()

        Conout(A2_COD + " - " + A2_NREDUZ)

        DbSelectArea(cAliasFor)
        DbSkip()

    End

    DbSelectArea(cAliasFor)
    DbCloseArea()


    RESET ENVIRONMENT
Return 
