#INCLUDE "PROTHEUS.CH"


/*
+============================================================================================================+
| Função:    [ ZMPVAR01 ]                                                                                    |
| Descrição: [ FUNÇÃO DE TESTE PARA MANIPULAÇÃO DE VARIAVEL ]                                                |
| Autor:     [ FERNANDO JOSE RODRIGUES ]                                                                     |
| Data Criacao: [ 23/05/2022 ]                                                                               |
| Última Alteração: [  ]                                                                                     |
+============================================================================================================+
*/

User Function zMpVar01()
    LOCAL cVarTxt := ""
    LOCAL cVarBd := "PI.17"
    

    cVarTxt := AllTrim(StrTran(cVarBd, ".", "-"))

    If Len(cVarTxt) >= 7 .AND. Len(cVarTxt) <= 13
        
        MsgAlert(SubStr(cVarTxt, 1, 7), "Manipulação de Variavel")

    ElseIF Len(cVarTxt) >= 5 .AND. Len(cVarTxt) < 7

        MsgAlert(SubStr(cVarTxt, 1, 5), "Manipulação de Variavel")

    Else

        MsgAlert(cVarTxt, "Manipulação de Variavel")

    EndIf

Return
