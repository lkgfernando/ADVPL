#Include "Totvs.ch"

/*
+============================================================================================================+
| Fun��o: [ ZLOGI16 ==> IR� CONTAR REGISTRO DO CADASTRO DE CLIENTES UTILIZANDO SQL EMBEDDED ]               |
| Fun��o: [  ]                                                                                              |
| Autor:  [ FERNANDO ]                                                                                      |
| Data Criacao: [ 11/02/2022 ]                                                                              |
| �ltima Altera��o: [  ]                                                                                    |
+============================================================================================================+
*/

User Function ZLOGI16()
Local aArea := GetArea()
Local nAtual := 0

BeginSql Alias "QRY_SA1"
    SELECT 
        A1_COD,
        A1_NOME
    FROM 
        %table:SA1% SA1
    WHERE
        A1_FILIAL = %xFilial:SA1%
        AND A1_MSBLQL != '1'
        AND SA1.%notDel%

EndSql

While ! QRY_SA1->(EOF())
    nAtual++

    QRY_SA1->(DbSkip())    
EndDo
QRY_SA1->(DbCloseArea()) //Fechamento da Alias

MsgInfo(cValToChar(nAtual)+ " Cliente(s) encontrado(s) ", "Aten��o!!")


RestArea(aArea)

Return
