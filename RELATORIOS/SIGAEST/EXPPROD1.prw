#Include 'Protheus.ch'
#Include 'Topconn.ch'

/*
+============================================================================================================+
| Função: [ EXPROD1 ==> EXPORTAR PARA EXCEL LISTAGEM DE PRODUTO ]                                           |
| Autor:  [ FERNANDO ]                                                                                      |
| Data Criacao: [ 09/02/2022 ]                                                                              |
| Última Alteração: [  ]                                                                                    |
+============================================================================================================+
*/

User Function EXPROD1()
Local aArea := GetArea()
Local aCabec := {}
Local aDados := {}
Local cQuery := {}

//Cabeçalho da relatorio

aCabec := {"CODIGO","DESCRICAO","TIPO","ARMAZEM","GRUPO","NCM","ULTIMA_REVISAO"}

cQuery := " SELECT B1_COD, B1_DESC, B1_TIPO, B1_LOCPAD, B1_GRUPO, B1_POSIPI,B1_UREV FROM "+RetSqlName("SB1")+" AS SB1 "
cQuery += " WHERE SB1.D_E_L_E_T_ <> '*'"

TCQUERY cQuery new Alias "SB1"

//VERIFICA SE A AREA DO ARQUIVO ESTÁ ABERTO
If SELECT("SB1") > 0
    SB1->(DbCloseArea())
EndIf

Do while !SB1->(EOF()) //Enquanto não Chegar ao final do arquivo, continue lendo

    aAdd(aDados,{SB1->B1_COD,SB1->B1_DESC,SB1->B1_TIPO,SB1->B1_LOCPAD,SB1->B1_GRUPO,SB1->B1_POSIPI,SB1->B1_UREV})

SB1->(DbSkip()) //Passa para o próximo registro

enddo

SB1->(DbCloseArea())

//Exportando para Excel
DlgToExcel({{"ARRAY","Relatorio de Produtos",aCabec,aDados}})

RestArea(aArea)
    
Return
