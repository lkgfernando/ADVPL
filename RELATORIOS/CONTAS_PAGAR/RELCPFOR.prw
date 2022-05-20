#Include "Protheus.ch"
#Include "Topconn.ch"

/*
+============================================================================================================+
| Função: [ RELCPFOR ==> EXPORTA RELATORIO DE CONTAS A PAGAR POR FORNECEDOR ]                               |
| Função: [ RELCPFOR ]                                                                                      |
| Autor:  [ FERNANDO ]                                                                                      |
| Data Criacao: [ 10/02/2022 ]                                                                              |
| Última Alteração: [  ]                                                                                    |
+============================================================================================================+
*/

User Function RELCPFOR()
Local aArea := GetArea()
Local cAlias := GetNextAlias() //Declaração de Alias
Private aCabec := {}
Private aDados := {}
Private cPerg := "TRFOR" //Variavel que armazena o nome do grupo de Pergunta

//Funcao que cria as perguntas/filtros que iremos usar no relatorio, na SX1
ValidPerg()

//Funcao responsavel por charmar a pergunta na funcao validaPerg, a variavel Private cPerg, é passada

Pergunte(cPerg, .T.)

//Consulta SQL
BeginSql Alias cAlias
    SELECT E2_PREFIXO, E2_NUM, A2_COD, A2_NOME, E2_VALOR FROM %table:SE2% SE2
    INNER JOIN %table:SA2% SA2 ON SE2.E2_FORNECE = SA2.A2_COD AND SE2.E2_LOJA = SA2.A2_LOJA
    WHERE E2_FORNECE BETWEEN %exp:(MV_PAR01)% AND %exp:(MV_PAR02)%
    AND SE2.%notdel% AND SA2.%notdel%

EndSql

//Cabecalho
aCabec := {"PREFIXO","TITULO","COD_FORNECEDOR","NOME_FORNECEDOR","VALOR_TITULO"}

Do while !(cAlias)->(EOF())

    aAdd(aDados,{E2_PREFIXO,E2_NUM,A2_COD,A2_NOME,E2_VALOR})

    (cAlias)->(DbSkip())

EndDo

//Colocar dentro do conteu do arrqy o Excel

DlgToExcel({{"ARRAY","Relatorio de Titulos a pagar",aCabec, aDados}})

(cAlias)->(DbCloseArea())
RestArea(aArea)

Return

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
