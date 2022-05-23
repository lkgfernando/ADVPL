#INCLUDE "PROTHEUS.CH"

/*
+============================================================================================================+
| Função: [ zTPVAR01 ]                                                                                       |
| Função: [ Converções de Variaveis ]                                                                        |
| Autor:  [ Fernando Jose Rodrigues ]                                                                        |
| Data Criacao: [ 20/05/2022 ]                                                                               |
| Última Alteração: [  ]                                                                                     |
+============================================================================================================+
*/
User Function zTpVar01()
    LOCAL dDate := cToD("20/05/2022")
    LOCAL cMessenger := ""
    LOCAL sData := dToS(dDate)

    cMessenger := dToC(dDate) + CRLF
    cMessenger += sData
    
    
Return MsgAlert(cMessenger, "Tipo de Varia")
