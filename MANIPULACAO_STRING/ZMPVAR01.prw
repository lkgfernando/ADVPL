#INCLUDE "PROTHEUS.CH"


/*
+============================================================================================================+
| Fun��o:    [ ZMPVAR01 ]                                                                                    |
| Descri��o: [ FUN��O DE TESTE PARA MANIPULA��O DE VARIAVEL ]                                                |
| Autor:     [ FERNANDO JOSE RODRIGUES ]                                                                     |
| Data Criacao: [ 23/05/2022 ]                                                                               |
| �ltima Altera��o: [  ]                                                                                     |
+============================================================================================================+
*/

User Function zMpVar01()
    LOCAL cVarTxt := ""
    LOCAL cVarBd := "PI.760.BR"
    

    cVarTxt := AllTrim(StrTran(cVarBd, ".", ""))

    If Len(cVarTxt) = 11
        
        MsgAlert(SubStr(cVarTxt, 1, 6), "Manipula��o de Variavel")

    ElseIF Len(cVarTxt) = 6 

        MsgAlert(SubStr(cVarTxt, 1, 4), "Manipula��o de Variavel")

    ElseIf Len(cVarTxt) = 5

        MsgAlert(cVarTxt, "Manipula��o de Variavel")

    EndIf

Return
