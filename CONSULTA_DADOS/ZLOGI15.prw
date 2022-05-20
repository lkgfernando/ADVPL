#Include 'Totvs.ch'

/*
+============================================================================================================+
| Função: [ ZLOGI15 ==> FUNÇÃO PARA MONTAR UMA QUERY SQL NO ADVPL ]                                         |
| Função: [  ]                                                                                              |
| Autor:  [ FERNANDO ]                                                                                              |
| Data Criacao: [ 11/02/2022 ]                                                                              |
| Última Alteração: [  ]                                                                                    |
+============================================================================================================+
*/

User Function ZLOGI15()
Local aArea := GetArea()
Local cQrySA2 := ""
Local nAtual := 0

//Selecionado fornecedores via query diretamente no bando de dados
cQrySA2 := " SELECT " + CRLF
cQrySA2 += "    A2_COD, " + CRLF
cQrySA2 += "    A2_NOME " + CRLF
cQrySA2 += " FROM " + CRLF
cQrySA2 += "    " + RetSQLName('SA2') + " SA2 " + CRLF
cQrySA2 += " WHERE " + CRLF
cQrySA2 += "    A2_FILIAL = '" + FwxFilial('SA2') + "' " + CRLF
cQrySA2 += "    AND A2_MSBLQL != '1' " + CRLF
cQrySA2 += "    AND SA2.D_E_L_E_T_ != '*'  " + CRLF
cQrySA2 += " ORDER BY " + CRLF
cQrySA2 += "    A2_COD  " 

//Executando a query
PLSQuery(cQrySA2, "QRY_SA2")

//Enquanto houver dados da query

While ! QRY_SA2->(EOF())
    nAtual++

    QRY_SA2->(DbSkip())
Enddo

QRY_SA2->(DbCloseArea())

MsgInfo(cValToChar(nAtual) + " Fornecedor(es) encontrado(s)!", "Atenção!!!")

RestArea(aArea)

Return
