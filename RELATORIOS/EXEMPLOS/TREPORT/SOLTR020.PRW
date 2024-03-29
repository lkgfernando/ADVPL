#Include "Totvs.ch"
#Include "Topconn.ch"


/*
+============================================================================================================+
| Fun��o: [ SOLTR010 ==> RELATORIO DE SOLICITACAO DE COMPRA ]                                                |
| Fun��o: [ SOLTR010 ]                                                                                       |
| Autor:  [ FERNANDO JOSE RODRIGUES ]                                                                       |
| Data Criacao: [ 15/03/2022 ]                                                                              |
| �ltima Altera��o: [  ]                                                                                    |
+============================================================================================================+
*/


User Function SOLTR010()
PRIVATE oReport := Nil
PRIVATE oSecCab := Nil
PRIVATE cPerg   := "COMTR010"

Pergunte(cPerg, .T.)

//Chamando a fun��o para constru��o do relat�rio
ReportDef()
oReport:PrintDialog()

Return

/*ESTRUTURA DO RELAT�RIO*/
Static Function ReportDef()

oReport := TReport():New("SOLTR010", "SOLICITA��O DE COMPRAS", cPerg, {|oReport| PrintReport(oReport)}, "Relatorio de Solicita��o de Compra")
/*CONFIGURA��O DO PAPEL PAISAGEM OU RETRATO*/
oReport:SetLandscape(.T.)


/*SE��O DO RELATORIO TEREMOS APENAS UMA SE��O*/
oSecCab := TRSection():New( oReport, "SOLICITAC�ES", {"SQL"})

TRCell():New(oSecCab, "C1_NUM"    , "SC1")
TRCell():New(oSecCab, "C1_ITEM"   , "SC1")
TRCell():New(oSecCab, "C1_PRODUTO", "SC1")
TRCell():New(oSecCab, "C1_DESCRI" , "SC1")
TRCell():New(oSecCab, "C1_UM"     , "SC1")
TRCell():New(oSecCab, "C1_QUANT"  , "SC1")
TRCell():New(oSecCab, "C1_SEGUM"  , "SC1")
TRCell():New(oSecCab, "C1_QTSEGUM", "SC1")
TRCell():New(oSecCab, "C1_SOLICIT", "SC1")

TRFunction():New(oSecCab:Cell("C1_ITEM"),,"COUNT",,,,,.F.,.T.,.F.,oSecCab)




Return

/*FUN��O PARA TRAZER OS DADOS*/
Static Function PrintReport(oReport)
LOCAL cAlias := GetNextAlias()

oSecCab:BeginQuery()
    BeginSql Alias cAlias
        SELECT
            C1_NUM,
            C1_ITEM,
            C1_PRODUTO,
            C1_DESCRI,
            C1_UM,
            C1_QUANT,
            C1_SEGUM,
            C1_QTSEGUM,
            C1_SOLICIT
        FROM
            %table:SC1%
        WHERE
            %notDel% AND C1_NUM BETWEEN %exp:(MV_PAR01)% AND %exp:(MV_PAR02)%
    EndSql

oSecCab:EndQuery()
oSecCab:Print()

(cAlias)->(DbCloseArea())
    
Return
