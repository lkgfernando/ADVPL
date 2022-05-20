#Include "Totvs.ch"


/*
+============================================================================================================+
| Fun��o: [ REST002 ==> IR� CONSUMIR DADOS DA API CRIADA NA FUN��O REST001 ]                                |
| Fun��o: [ REST002 ]                                                                                       |
| Autor:  [ FERNANDO JOSE RODRIGUES ]                                                                       |
| Data Criacao: [ 17/02/2022 ]                                                                              |
| �ltima Altera��o: [  ]                                                                                    |
+============================================================================================================+
*/

User Function REST002()
Local cUrl := "http://10.10.1.4:5040/rest/" //Define endere�o da url do rest
Local cPath := "helloword?mensagem=OlaMundo" //Servi�o que criei no REST
Local oRest  //Cria varial para o objeto REST
Local aHeader := {}

//Consumindo com atoriza��o basica
aAdd(aHeader, "Authorization: BASIC " + Encode64("aplicativo:123456"))

//Instancia o objeto
oRest := FwRest():New(cUrl)

//Define o recurso que ser� usado
oRest:setPath(cPath)

//Chama o metodo GET
If oRest:get(aHeader)
    MsgAlert(oRest:GetResult(), "Retorno Rest")
else
    MsgAlert(oRest:GetLastError(), "Erro !!!")
EndIf

Return
