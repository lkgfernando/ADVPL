#INCLUDE "PROTHEUS.CH"

/*
+============================================================================================================+
| Fun��o: [ zTPVAR01 ]                                                                                       |
| Fun��o: [ Conver��es de Variaveis ]                                                                        |
| Autor:  [ Fernando Jose Rodrigues ]                                                                        |
| Data Criacao: [ 20/05/2022 ]                                                                               |
| �ltima Altera��o: [  ]                                                                                     |
+============================================================================================================+
*/
User Function zTpVar01()
    LOCAL dDate := cToD("20/05/2022")
    LOCAL cMessenger := ""
    LOCAL sData := dToS(dDate)

    cMessenger := dToC(dDate) + CRLF
    cMessenger += sData
    
    
Return MsgAlert(cMessenger, "Tipo de Varia")
