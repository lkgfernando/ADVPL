#Include "Protheus.ch"
#Include "Topconn.ch"

/*
+============================================================================================================+
| Fun��o: [ TRFOR02 ==> IMPRIME RELAT�RIO CONTAS A PAGAR POR FORNECEDOR ]                                   |
| Fun��o: [ TRFOR02 ]                                                                                       |
| Autor:  [ FERNANDO ]                                                                                      |
| Data Criacao: [ 10/02/2022 ]                                                                              |
| �ltima Altera��o: [  ]                                                                                    |
+============================================================================================================+
*/

User Function TRFOR02()
Private oReport := Nil
Private oSecCab := Nil
Private cPerg   := "TRFOR"

//Fun��o que cria as perguntas/filtros que iremos usar no relatorio, na SX1
ValidPerg()

//Fun��o Respons�vel por chamar a pergunta criada na fun��o ValidPerg, a Variavel Private cPerg, � passada.
Pergunte(cPerg,.T.)

//Chama as static function criadas para o Relat�rio
ReportDef()
oReport:PrintDialog()

Return 

//Montagem da static function ReportDef
Static Function ReportDef()

oReport := TReport():New("TRFOR02","Relat�rio - Titulos por Fornecedor",cPerg,{|oReport| PrintReport(oReport)},"Relat�rio de Titulos por Fornecedor")

oReport:SetLandscape(.T.)

//TrSection serve para controle de se��o do relat�rio, neste caso teremos somente uma
oSecCab := TRSection():New( oReport, "TITULOS POR FORNECEDOR" )

/*
TrCell serve para inserir os campos/colunas que voc� quer no relat�rio, lembrando que devem ser os mesmo campos que cont�m na QUERY
Um detalhe importante, todos os campos contidos nas linha abaixo, devem estar no QUERY
*/
TRCell():New( oSecCab, "E2_NUM", "SE2"   )
TRCell():New( oSecCab, "A2_COD", "SA2"   )
TRCell():New( oSecCab, "A2_NOME", "SA2"  )
TRCell():New( oSecCab, "E2_VALOR", "SE2" )
TRCell():New( oSecCab, "E2_SALDO", "SE2" )

oBreak := TRBreak():New(oSecCab,oSecCab:Cell("A2_COD"), "Sub Total Titulos")

//Est� linha ira contar a quantidade de registro listado no relat�rio para a unica se��o que temos
TRFunction():New(oSecCab:Cell("E2_VALOR"),NIL,"SUM",oBreak)
TRFunction():New(oSecCab:Cell("E2_SALDO"),NIL,"SUM",oBreak)

TRFunction():New(oSecCab:Cell("A2_COD"),,"COUNT")


Return

//Stitic function para montagem da QUERY
Static Function PrintReport(oReport)
Local cAlias := GetNextAlias()

oSecCab:BeginQuery()

BeginSql Alias cAlias

    SELECT E2_PREFIXO, E2_NUM, A2_COD, A2_NOME, E2_VALOR, E2_SALDO FROM %table:SE2% SE2
    INNER JOIN %table:SA2% SA2 ON SE2.E2_FORNECE = SA2.A2_COD AND SE2.E2_LOJA = SA2.A2_LOJA
    WHERE E2_FORNECE BETWEEN %exp:(MV_PAR01)% AND %exp:(MV_PAR02)%
    AND SE2.D_E_L_E_T_ <> '*' AND SA2.D_E_L_E_T_ <> '*'  

EndSql

oSecCab:EndQuery() //Fim da QUERY
oSecCab:Print() // � dada a ordem da impress�o, visto os filtros selecionados

(cAlias)->(DbCloseArea())
    
Return


//Verifica se a Pergunta existe caso n�o exista cria o grupo de perguntas.
Static Function ValidPerg()
Local aArea := SX1->(GetArea())
Local aRegs := {}
Local i,j := ""


aAdd( aRegs, { cPerg,"01","Fornecedor de ?","Fornecedor de ?","Fornecedor de ?","MV_CH1","C",6,0,0,"G","","MV_PAR01","","","MV_PAR01","","","","","","","","", ;
"","","","","","","","","","","","","","SA2" })

aAdd( aRegs, { cPerg,"02","Fornecedor ate ?","Fornecedor ate ?","Fornecedor ate ?","MV_CH2","C",6,0,0,"G","","MV_PAR02","","","MV_PAR02","","","","","","","","", ;
"","","","","","","","","","","","","","SA2" })

DbSelectArea('SX1')
SX1->(DBSETORDER(1))
for i := 1 to Len(aRegs)
    If ! SX1->(DBSEEK( AvKey(cPerg,"X1_GRUPO") + aRegs[i,2]) )
        RecLock('SX1', .T.)
        for j := 1 To SX1->( FCOUNT() )
            If j <= Len(aRegs[i])
                FieldPut(j,aRegs[i,j])
            EndIf                    
        next j
        SX1->(MsUnLock())
    EndIf
next i

RestArea(aArea)
Return (cPerg)
