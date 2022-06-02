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
    LOCAL cVarBd := "PI.760.BR"
    

    cVarTxt := AllTrim(StrTran(cVarBd, ".", ""))

    If Len(cVarTxt) = 11
        
        MsgAlert(SubStr(cVarTxt, 1, 6), "Manipulação de Variavel")

    ElseIF Len(cVarTxt) = 6 

        MsgAlert(SubStr(cVarTxt, 1, 4), "Manipulação de Variavel")

    ElseIf Len(cVarTxt) = 5

        MsgAlert(cVarTxt, "Manipulação de Variavel")

    EndIf

Return
