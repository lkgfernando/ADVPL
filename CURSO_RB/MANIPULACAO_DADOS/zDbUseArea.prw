#Include "Totvs.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"


/*/{Protheus.doc} User Function zDbUserArea
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 25/04/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zDbUserArea()
    Local aArea := FWGetArea()
    Local aSay := {}
    Local aButton := {}
    Local nOpc := 0
    Local cTitulo := "Exemplo de Funções"
    Local cDesc1 := "Este programa exemplifica a utilização da função processa() em conjunto"
    Local cDesc2 := "com as funções de incremento ProcRegua() e IncProc()"


    If SELECT("SX6") > 0
        Alert("Protheus Aberto")
    else
        PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "FAT"

    EndIf

    aAdd( aSay, cDesc1)
    aAdd( aSay, cDesc2)
    aAdd( aButton, {1, .T., {|| nOpc := 1, FechaBatch()}} )
    aAdd( aButton, {2, .T., {|| FechaBatch()}} )

    FormBatch( cTitulo, aSay, aButton)

    If nOpc <> 1
        Return
    EndIf

    RptStatus({|lEnd| RunProc(@lEnd)}, "Aguarde...", "Executando rotina", .T.)

    RESET ENVIRONMENT
    FWRestArea(aArea)

Return 


/*/{Protheus.doc} RunProc
    (long_description)
    @type  Static Function
    @author Fernando José Rodrigues
    @since 25/04/2023
    @version 1.0
    @param lEnd, , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function RunProc(lEnd)
    Local nCnt := 0
    Local cAliasFor
    Local cSql := ""
    Local nRec := 0

    cAliasFor := GetNextAlias()

    cSql := " SELECT " + CRLF
    cSql += "   A2_FILIAL," + CRLF
    cSql += "   A2_COD, " + CRLF
    cSql += "   A2_LOJA, " + CRLF
    cSql += "   A2_NREDUZ, " + CRLF
    cSql += "   A2_EST, " + CRLF
    cSql += "   A2_MSBLQL, " + CRLF
    cSql += "   A2_ULTCOM " + CRLF
    cSql += " FROM " + CRLF
    cSql += "       " + RetSqlName("SA2") + " " + CRLF
    cSql += " WHERE " + CRLF
    cSql += "       A2_FILIAL = '" + xFilial("SA2") + "' " + CRLF
    cSql += "       AND D_E_L_E_T_ <> '*' " + CRLF
    cSql += "       AND A2_ULTCOM <= '" + Dtos(Date()) + "' " 

    MemoWrite("AULA_DB_USE_AREA.SQL", cSql)


    DbUseArea(.T., "TOPCONN", TcGenQry(, , cSql), (cAliasFor), .F., .T.) 

    Count To nRec

    If nRec == 0
        Alert("Não foram encontrados dados, refaça os parâmetros", "Atnção")
        DbSelectArea(cAliasFor)
        DbCloseArea()
        Return
    EndIf

    DbSelectArea(cAliasFor)
    DbGoTop()

    While !Eof() .And. (cAliasFor)->A2_FILIAL == xFilial("SA2") .And. (cAliasfor)->A2_MSBLQL <> '1'
        nCnt++
        DbSkip()
    End


    SetRegua(nCnt)


    DbSelectArea(cAliasFor)
    DbGoTop()
    While !Eof() .And. (cAliasFor)->A2_FILIAL == xFilial("SA2") .And. (cAliasfor)->A2_MSBLQL <> '1'
        IncRegua()
        Conout(A2_COD + " - " + A2_NREDUZ)

        DbSelectArea(cAliasFor)
        DbSkip()

    End
    

    DbSelectArea(cAliasFor)

    DbCloseArea()


Return 
