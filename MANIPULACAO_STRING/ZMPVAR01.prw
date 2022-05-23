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
    LOCAL cVarBd := "PI.17"
    

    cVarTxt := AllTrim(StrTran(cVarBd, ".", "-"))

    If Len(cVarTxt) >= 7 .AND. Len(cVarTxt) <= 13
        
        MsgAlert(SubStr(cVarTxt, 1, 7), "Manipula��o de Variavel")

    ElseIF Len(cVarTxt) >= 5 .AND. Len(cVarTxt) < 7

        MsgAlert(SubStr(cVarTxt, 1, 5), "Manipula��o de Variavel")

    Else

        MsgAlert(cVarTxt, "Manipula��o de Variavel")

    EndIf

Return
