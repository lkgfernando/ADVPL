#Include "Totvs.ch"


/*
+============================================================================================================+
| Função: [ REST002 ==> IRÁ CONSUMIR DADOS DA API CRIADA NA FUNÇÃO REST001 ]                                |
| Função: [ REST002 ]                                                                                       |
| Autor:  [ FERNANDO JOSE RODRIGUES ]                                                                       |
| Data Criacao: [ 17/02/2022 ]                                                                              |
| Última Alteração: [  ]                                                                                    |
+============================================================================================================+
*/

User Function REST002()
Local cUrl := "http://10.10.1.4:5040/rest/" //Define endereço da url do rest
Local cPath := "helloword?mensagem=OlaMundo" //Serviço que criei no REST
Local oRest  //Cria varial para o objeto REST
Local aHeader := {}

//Consumindo com atorização basica
aAdd(aHeader, "Authorization: BASIC " + Encode64("aplicativo:123456"))

//Instancia o objeto
oRest := FwRest():New(cUrl)

//Define o recurso que será usado
oRest:setPath(cPath)

//Chama o metodo GET
If oRest:get(aHeader)
    MsgAlert(oRest:GetResult(), "Retorno Rest")
else
    MsgAlert(oRest:GetLastError(), "Erro !!!")
EndIf

Return
